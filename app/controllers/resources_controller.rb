class ResourcesController < ApplicationController
  before_action :set_resource, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!


  # GET /resources
  # GET /resources.json
  def index
    @resources = Resource.all
    if params[:search].present?
       @resources = Resource.search(params[:search])
    end
    @user = current_user 

    pair = current_user.sort_resources_and_distance(@resources)
    @resources = pair[0]

    resource_array =[]
    resource_array2 =[]

    @resources.each do |resource_distance_pair|
      if resource_distance_pair[0].user != current_user 
        resource_array <<  resource_distance_pair[0].as_json.merge({distance: resource_distance_pair[1]})
        resource_array2 << resource_distance_pair[0] 
      end 
    end 
   @jason = resource_array.to_json

   @hash = Gmaps4rails.build_markers(resource_array2) do |resource, marker|
     marker.lat resource.user.latitude
     marker.lng resource.user.longitude
     marker.json({title: render_to_string(:partial => "map_label", :locals => {:mapped_resource => resource})})
     marker.infowindow render_to_string(:partial => "map_infobox", :locals => {:mapped_resource => resource})
     # marker.picture({
     #   "url" => "https://addons.cdn.mozilla.net/img/uploads/addon_icons/13/13028-64.png",
     #   "width" => 100,
     #   "height" => 100})
     # marker.title "popresource.name"

   end

  end

  # GET /resources/1
  # GET /resources/1.json
  def show
    @user = current_user
    @borrow = @resource.borrows.build

    @distance = @user.resource_distance(@resource)
    @hash = Gmaps4rails.build_markers([@resource.user]) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      marker.json({title: render_to_string(:partial => "map_label", :locals => {:mapped_resource => @resource})})
      marker.infowindow render_to_string(:partial => "map_infobox", :locals => {:mapped_resource => @resource})
    end
  end



  # GET /resources/new
  def new
    @resource = Resource.new
    @resource.picture = File.open("public/assets/tool-default.png")
    @user = current_user
  end

  # GET /resources/1/edit
  def edit
    @user = current_user
    if (@user != @resource.user)
      redirect_to user_resource_path 
    end
  end

  # POST /resources
  # POST /resources.json
  def create
    @resource = Resource.new(resource_params)
    @resource.user = current_user


    if !resource_params['picture']
      @resource.picture = File.open("public/assets/tool-default.png")
    end

    respond_to do |format|
      if @resource.save
        format.html { redirect_to current_user, notice: 'Resource was successfully created.' }
        format.json { render action: 'show', status: :created, location: @resource }
      else
        format.html { render action: 'new' }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /resources/1
  # PATCH/PUT /resources/1.json
  def update
    respond_to do |format|
      if @resource.update(resource_params)
        format.html { redirect_to user_resource_path, notice: 'Resource was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resources/1
  # DELETE /resources/1.json
  def destroy
    @resource.destroy
    respond_to do |format|
      format.html { redirect_to resources_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resource
      @resource = Resource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      params.require(:resource).permit(:name, :description, :picture)
    end

    # Attempt to get @user to this page
    def set_user
      @user = User.find(params[:id])
    end
end
