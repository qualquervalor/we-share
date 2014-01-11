class AddUserAndBorrowsToResource < ActiveRecord::Migration
  def change
    add_reference :resources, :user, index: true
    add_reference :resources, :borrow, index: true
  end
end
