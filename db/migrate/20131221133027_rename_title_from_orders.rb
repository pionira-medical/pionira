class RenameTitleFromOrders < ActiveRecord::Migration
  def change
    rename_column :orders, :title, :dr_title
  end
end
