require 'spec_helper'

describe BorrowsController do
  
  login_user

  it "should have a current_user" do
    # note the fact that I removed the "validate_session" parameter if this was a scaffold-generated controller
    subject.current_user.should_not be_nil
  end

  it "should get index" do
    get 'index'
    response.should be_success
  end

  # describe "GET show" do
  #   it "assigns the current_user as @user" do

  #     Actor = Actor.create! valid_attributes
  #     get :show, {:id => Actor.to_param}, valid_session
  #     assigns(:Actor).should eq(Actor)
  #   end
  # end


  # describe "GET index" do
  #   it "assigns all Actors as @Actors" do
  #     Actor = Actor.create! valid_attributes
  #     get :index, {}, valid_session
  #     assigns(:Actors).should eq([Actor])
  #   end
  # end


  # describe "GET new" do

  #   it "should get new" do
  #     get :new
  #     assert_response :success
  #   end

  # end



end