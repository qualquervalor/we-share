class RegistrationsController < Devise::RegistrationsController
 
  def new
     build_resource({})   
     #render layout: "landing_page" 
     respond_with self.resource, layout: "landing_page"
  end
# Started GET "/users/sign_up" for 127.0.0.1 at 2014-01-24 14:50:11 -0600
# Processing by RegistrationsController#new as HTML
#   Rendered shared/_error_messages.html.erb (0.1ms)
#   Rendered devise/shared/_links.erb (0.3ms)
#   Rendered devise/registrations/new.html.erb within layouts/landing_page (5.9ms)


# WE need to change the create respond_with for cases where the user has a validation issues, it currenlty 
# uses the wrong layout
  def create
    build_resource(sign_up_params)

    if resource.save
      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource,  :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource,  :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      # respond_with resource, layout: "landing_page"
      render layout: "landing_page"
    end
  end
#
# Processing by RegistrationsController#create as HTML
#   Parameters: {"utf8"=>"✓", "authenticity_token"=>"3uOpVY4MDdUSPbyF0jQ/48yFWYwtUprlnHXyN4X2ICw=", "user"=>{"name"=>"", "email"=>"ted@gmail.com", "password"=>"[FILTERED]", "password_confirmation"=>"[FILTERED]", "street"=>"", "city"=>"", "state"=>"", "zipcode"=>""}, "commit"=>"Sign up"}
#    (0.1ms)  BEGIN
#   User Exists (7.4ms)  SELECT 1 AS one FROM "users" WHERE "users"."email" = 'ted@gmail.com' LIMIT 1
#    (0.1ms)  ROLLBACK
#   Rendered shared/_error_messages.html.erb (0.2ms)
#   Rendered devise/shared/_links.erb (0.8ms)
#   Rendered devise/registrations/new.html.erb within layouts/application (26.7ms)
# Completed 200 OK in 501ms (Views: 118.1ms | ActiveRecord: 7.6ms)


  protected

    def after_update_path_for(user)
      user_path(user)
    end

end