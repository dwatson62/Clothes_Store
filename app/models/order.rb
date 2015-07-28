class Order < ActiveRecord::Base

  has_and_belongs_to_many :products

  include VouchersHelper

  def update_total
    self.subtotal = self.products.sum(:price)
    self.total = self.subtotal - self.discount
    self.save
  end

  def apply_voucher(voucher)
    self.discount += voucher['discount']
    self.save
  end

  def remove_discounts
    self.discount = 0
    self.save
  end

end
