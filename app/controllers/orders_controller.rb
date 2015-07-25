class OrdersController < ApplicationController

  include ActionView::Helpers::NumberHelper

  def index
    @order = Order.first_or_create
    @products = Product.all
    @order.update_total
    @available_voucher = @order.prepare_voucher
    @ordered_products = @order.products.to_a
  end

  def update
    order = Order.find(params[:id])
    voucher = order.prepare_voucher
    order.apply_voucher(voucher)
    redirect_to '/'
  end

end
