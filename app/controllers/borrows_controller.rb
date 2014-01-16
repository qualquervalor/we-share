class BorrowsController < ApplicationController
  before_action :set_borrow, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  include BorrowsHelper
  # GET /borrows
  # GET /borrows.json
  def index
    @borrows = Borrow.all
  end

  # GET /borrows/1
  # GET /borrows/1.json
  def show
    @user = current_user
  end

  # GET /borrows/new
  def new
    @resource = Resource.find(params[:resource])
    @borrow = @resource.borrows.build  
    if current_user == @resource.user
      redirect_to @resources
    end
  end

  # GET /borrows/1/edit
  def edit
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
    respond_to do |format|
      if @borrow.save 
   
        #Action Mailer - Request sent to Owner
        Notifier.borrowrequest(@borrow.resource.user,msg).deliver

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
    
    if params['commit'] == POSITIVE_RESPONSE
      params['borrow']['status'] = Borrow.borrowed
      #Action Mailer - Accepted email
      Notifier.borrowaccept(@borrow.user).deliver

    elsif  params['commit'] == NEGATIVE_RESPONSE
      params['borrow']['status'] = Borrow.denied
      #Action Mailer - Denied email
      Notifier.borrowdenied(@borrow.user).deliver

    elsif  params['commit'] == BORROW_COMPLETED
      params['borrow']['status'] = Borrow.returned
      #action mailer send out negative email

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
