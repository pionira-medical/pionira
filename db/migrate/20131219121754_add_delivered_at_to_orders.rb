class AddDeliveredAtToOrders < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.datetime :delivered_at
    end
  end
end
