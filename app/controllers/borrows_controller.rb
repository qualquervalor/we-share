class BorrowsController < ApplicationController
  before_action :set_borrow, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  layout "small_page"
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
    @user = current_user
	  @resource = Resource.find(params[:resource])
    @borrow = @resource.borrows.build  

    if current_user == @resource.user
      redirect_to @resources
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
  end

  # POST /borrows
  # POST /borrows.json
  def create
    @borrow = Borrow.new(borrow_params)
    @borrow.user = current_user
    @borrow.status = Borrow.pending
    msg = params[:msg]
    resource = params[:resource]
    respond_to do |format|
      if @borrow.save 
        #Action Mailer - Request sent to User that just requested a Resource.
        Notifier.borrowrequest(@borrow.user,msg).deliver

        #Action Mailer - Request sent to Owner
        Notifier.borrowrequesttoowner(@borrow.resource.user,msg,resource).deliver

        format.html { redirect_to current_user, notice: 'Borrow was successfully created.' }
        format.json { render action: 'show', status: :created, location: @borrow }
      else
        format.html { render action: 'new' }
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
      Notifier.borrowaccept(@borrow.user, msg).deliver

    elsif  params['status'] == NEGATIVE_RESPONSE
      params['borrow']['status'] = Borrow.denied

      #Action Mailer - Denied email
      Notifier.borrowdenied(@borrow.user, msg).deliver

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

#TODO Send Owner Email so they know the borrow has been canceled 

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
