class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    if params[:search].present?
      @users = User.search(params[:search])
    end
    @user = current_user
    pair = current_user.sort_users_and_distance(@users)
    @users = pair[0]
    
    user_array =[]
    @users.each do |user_distance_pair|
      if user_distance_pair[0] != current_user 
        user_array <<  user_distance_pair[0].as_json.merge({distance: user_distance_pair[1]}) 
      end 
    end 
   @jason = user_array.to_json

  end


  # GET /users/1
  # GET /users/1.json
  def show
    @user_resources = @user.resources
    @their_requests = @user.their_requests
    @my_requests = @user.my_pending_requests

    @their_requests = Kaminari.paginate_array(@their_requests).page(params[:page]).per(4)
    @my_requests = Kaminari.paginate_array(@my_requests).page(params[:page]).per(4)


    borrowed_array =[]
    borrs = @user.my_borrows
    borrs.each do |res|
      time = time_ago_in_words(res.currently_checked_out.updated_at)
       borrowed_array <<  res.as_json.merge({time: time}) 
    end 
    @jason =borrowed_array.to_json

  end
    

  # GET /users/new
  def new
    redirect_to new_user_registration_path
  end

  # GET /users/1/edit
  def edit
    redirect_to edit_user_registration_path @user
  end

  # POST /users
  # POST /users.json
  def create

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :street, :city, :zipcode, :state, :phone_num, :picture, :picture_cache)
    end
end
