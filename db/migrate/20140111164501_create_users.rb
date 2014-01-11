class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :street
      t.string :city
      t.string :zipcode
      t.string :state
      t.string :phone_num
      t.text :picture

      t.timestamps
    end
  end
end
