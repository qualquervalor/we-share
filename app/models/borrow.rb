class Borrow < ActiveRecord::Base
  belongs_to :user
  belongs_to :resource

  def update_status(new_status)
    @borrow.status = new_status
    
  end
end
