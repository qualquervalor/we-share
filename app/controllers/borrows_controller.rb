class BorrowsController < ApplicationController
  before_action :set_borrow, only: [:show, :edit, :update, :destroy]

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
    @borrow = Borrow.new
    @resource = Resource.find(params[:id])
    if current_user == @resource.user
      redirect_to @resources
    end
  end

  # GET /borrows/1/edit
  def edit
  end

  # POST /borrows
  # POST /borrows.json
  def create
    @borrow = Borrow.new(borrow_params)
    @borrow.user = current_user
    @borrow.status = 'pending'

    respond_to do |format|
      if @borrow.save
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
    respond_to do |format|
      if @borrow.update(borrow_params)
        format.html { redirect_to @borrow, notice: 'Borrow was successfully updated.' }
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
