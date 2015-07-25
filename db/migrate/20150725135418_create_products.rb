class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :category
      t.float :old_price
      t.float :price
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
