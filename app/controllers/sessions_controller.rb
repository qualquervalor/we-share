class SessionsController < Devise::SessionsController

  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
     respond_with(resource, serialize_options(resource))
    #render layout: "landing_page"
  end

end