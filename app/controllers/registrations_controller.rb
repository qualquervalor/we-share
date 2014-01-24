class RegistrationsController < Devise::RegistrationsController

  def new
      build_resource({})
      #render layout: "landing_page" 
       respond_with self.resource
  end



  # POST /resource
  def create
    build_resource(sign_up_params)

    if !user_params['picture']
      @user.picture = File.open("public/assets/shed_shot.png")
    end

    if resource.save
      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  protected

    def after_update_path_for(user)
      user_path(user)
    end

     def user_params
      params.require(:user).permit(:name, :street, :city, :zipcode, :state, :phone_num, :picture, :picture_cache)
    end

end