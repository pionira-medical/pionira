class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.references :order, index: true

      t.timestamps
    end
  end
end
