class Order < ActiveRecord::Base

  belongs_to :user
  has_and_belongs_to_many :products

  VOUCHER1 = { 'description' => '$5.00 off your order', 'discount' => 5, 'minimum_order' => 5 }

  def apply_voucher1
    if self.subtotal >= VOUCHER1['minimum_order']
      self.discount += VOUCHER1['discount']
      self.save
    end
  end

end
