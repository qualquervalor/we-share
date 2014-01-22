class RegistrationsController < Devise::RegistrationsController

  def new
      
      build_resource({})
      render layout: "landing_page"
      # respond_with self.resource

  end

  protected

    def after_update_path_for(user)
      user_path(user)
    end

end