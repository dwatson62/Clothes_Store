class OrdersController < ApplicationController

  include ActionView::Helpers::NumberHelper

  def index
    @order = Order.first_or_create
    @products = Product.all.order(id: :desc).reverse
    @order.update_total
    if @order.discount == 0
      @available_voucher = @order.prepare_voucher
    end
    @ordered_products = @order.products.to_a
  end

  def update
    order = Order.find(params[:id])
    voucher = order.prepare_voucher
    order.apply_voucher(voucher)
    redirect_to '/'
  end

end
