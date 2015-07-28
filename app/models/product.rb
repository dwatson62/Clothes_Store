class Product < ActiveRecord::Base

  has_and_belongs_to_many :orders

  def add_item_decrease_quantity
    self.quantity -= 1
    self.save
  end

  def remove_item_increase_quantity
    self.quantity += 1
    self.save
  end

end
