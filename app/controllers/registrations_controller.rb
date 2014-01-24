class RegistrationsController < Devise::RegistrationsController
  layout "layouts/landing_page", only: [:new, :create]

  protected

    def after_update_path_for(user)
      user_path(user)
    end

end