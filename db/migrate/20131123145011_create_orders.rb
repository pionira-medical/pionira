class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :hospital
      t.string :department
      t.string :street_1
      t.string :street_2
      t.integer :zip
      t.string :city
      t.string :country
      t.string :gender
      t.string :title
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :reference
      t.string :security_key
      t.text :description

      t.timestamps
    end
  end
end
