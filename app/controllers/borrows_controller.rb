class BorrowsController < ApplicationController
  before_action :set_borrow, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  include BorrowsHelper

  # GET /borrows
  # GET /borrows.json
  # only an admin type view none of our current users need to see this view
  # def index
  #   @borrows = Borrow.all
  # end

  # GET /borrows/1
  # GET /borrows/1.json
  def show
    if (@borrow.user != current_user)
      redirect_to root_path
    end    
    @user = current_user
  end

  # GET /borrows/new
  def new
    if !params[:resource]
      redirect_to resources_path
    else    
      @user = current_user
  	  @resource = Resource.find(params[:resource])
      redirect_to  resources_show_path(id: @resource.id)
    end
  end

  # GET /borrows/1/edit
  def edit
    #check to see if resource is nil, happens if db is dirty
    if (@borrow.resource.nil?)
      redirect_to root_path
    elsif
    #add check to make sure only owner can edit borrow
    (@borrow.resource.user != current_user)
      redirect_to @borrow
    end
  	@user = current_user    
  	@pos = POSITIVE_RESPONSE
    @neg = NEGATIVE_RESPONSE
    @ret = BORROW_COMPLETED
    
    @borrowed = @borrow.resource.currently_checked_out
  end

  # POST /borrows
  # POST /borrows.json
  def create
    borrow_attrs  = { status: "Pending", 
                      user_id: current_user.id, 
                      resource_id: borrow_params['resource_id']}
    @borrow = Borrow.where(borrow_attrs).first_or_create
    msg = params[:msg]

    respond_to do |format|
      if @borrow.save 
        #Action Mailer - Request sent to User that just requested a Resource.
        Notifier.borrow_request(@borrow,msg).deliver

        #Action Mailer - Request sent to Owner
        Notifier.borrow_request_to_owner(@borrow.resource.user,msg,@borrow.resource).deliver

        format.html { redirect_to :controller => 'users', :action => 'show', :id => current_user.id, :anchor => 'requestsent' }
        format.json { render action: 'show', status: :created, location: @borrow }
      else
        format.html { resources_show_path(c @borrow.resource.id)  } 
        format.json { render json: @borrow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /borrows/1
  # PATCH/PUT /borrows/1.json
  def update
    msg = params[:msg]
    if params['status'] == POSITIVE_RESPONSE
      params['borrow']['status'] = Borrow.borrowed

      #Action Mailer - Accepted email
      Notifier.borrow_accept(@borrow, msg).deliver

    elsif  params['status'] == NEGATIVE_RESPONSE
      params['borrow']['status'] = Borrow.denied

      #Action Mailer - Denied email
      Notifier.borrow_denied(@borrow, msg).deliver

    elsif  params['status'] == BORROW_COMPLETED
      params['borrow']['status'] = Borrow.returned
    end  
    
    respond_to do |format|
      if @borrow.update(borrow_params)
        format.html { redirect_to current_user, notice: 'Borrow was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @borrow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /borrows/1
  # DELETE /borrows/1.json
  def destroy
    #Action Mailer - Request sent to Owner
    Notifier.borrow_cancel_to_owner(@borrow.resource.user,@borrow.resource).deliver

    @borrow.destroy

    respond_to do |format|
      format.html { redirect_to current_user }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_borrow
      @borrow = Borrow.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def borrow_params
      params.require(:borrow).permit(:status, :resource_id)
    end

end
