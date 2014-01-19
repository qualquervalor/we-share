class StaticPagesController < ApplicationController
  layout "landing_page"

  def show
   if current_user 
    redirect_to :resources 
   end 
  end
  
end
