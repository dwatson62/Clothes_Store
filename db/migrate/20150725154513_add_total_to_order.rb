class AddTotalToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :subtotal, :float, default: 0
    add_column :orders, :discount, :float, default: 0
    add_column :orders, :total, :float, default: 0
  end
end
