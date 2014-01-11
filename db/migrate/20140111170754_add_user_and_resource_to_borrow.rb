class AddUserAndResourceToBorrow < ActiveRecord::Migration
  def change
    add_reference :borrows, :user, index: true
    add_reference :borrows, :resource, index: true
  end
end
