class RegistrationsController < Devise::RegistrationsController
 layout "landing_page"
 
  def new
      
      build_resource({})   
      respond_with self.resource

  end

  protected

    def after_update_path_for(user)
      user_path(user)
    end

end