class AddResourcesAndBorrowsToUser < ActiveRecord::Migration
  def change
    add_reference :users, :resource, index: true
    add_reference :users, :borrow, index: true
  end
end
