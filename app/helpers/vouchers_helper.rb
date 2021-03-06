module VouchersHelper

  VOUCHER1 = { 'description' => '$5 off your order', 'discount' => 5, 'minimum_order' => 5, 'condition' => '', 'minimum_number' => 0 }
  VOUCHER2 = { 'description' => '$10 off when you spend over $50.00', 'discount' => 10, 'minimum_order' => 50, 'condition' => '', 'minimum_number' => 0 }
  VOUCHER3 = { 'description' => '$15 off when you have bought at least one footwear item and spent over $75.00', 'discount' => 15, 'minimum_order' => 75, 'condition' => 'Footwear', 'minimum_number' => 1 }

  def vouchers
    [VOUCHER1, VOUCHER2, VOUCHER3].sort_by { |voucher| voucher['discount'] }.reverse
  end

  def prepare_voucher
    return if self.discount > 0
    vouchers.each do |voucher|
      return voucher if can_apply_voucher?(voucher)
    end
  end

  def can_apply_voucher?(voucher)
    if self.products.where('category LIKE ?', "%" + voucher['condition'] + "%").length >= voucher['minimum_number']
      return true if self.subtotal > voucher['minimum_order']
    end
  end

end