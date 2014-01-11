class CreateBorrows < ActiveRecord::Migration
  def change
    create_table :borrows do |t|
      t.string :status

      t.timestamps
    end
  end
end
