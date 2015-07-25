class OrdersController < ApplicationController

  include ActionView::Helpers::NumberHelper
  include OrdersHelper

  def index
    @order = Order.first_or_create
    @products = Product.all
    @order.subtotal = @order.products.sum(:price)
    @order.total = @order.subtotal - @order.discount
    @order.save
    @total = number_to_currency(@order.total)
  end

  def update
    order = Order.find(params[:id])
    order.apply_voucher1
    redirect_to '/'
  end

end
