class Order < ActiveRecord::Base

  belongs_to :user
  has_and_belongs_to_many :products

  VOUCHER1 = { 'description' => '$5 off your order', 'discount' => 5, 'minimum_order' => 5 }
  VOUCHER2 = { 'description' => '$10 off when you spend over $50.00', 'discount' => 10, 'minimum_order' => 50 }

  def vouchers
    [VOUCHER1, VOUCHER2]
  end

  def apply_voucher1
    if self.subtotal >= VOUCHER1['minimum_order']
      self.discount += VOUCHER1['discount']
      self.save
    end
  end

  def apply_voucher2
    if self.subtotal > VOUCHER2['minimum_order']
      self.discount += VOUCHER2['discount']
      self.save
    end
  end

end
