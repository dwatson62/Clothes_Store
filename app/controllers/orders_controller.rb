class OrdersController < ApplicationController

  include ActionView::Helpers::NumberHelper

  def index
    @order = Order.first_or_create
    @categories = Product.all.order(category: :desc).map { |p| p.category }.uniq
    show_category = params[:category] || Product.first.category
    @products = Product.all.where(category: show_category)
    @order.update_total
    @ordered_products = @order.products.to_a
    @available_voucher = @order.prepare_voucher
  end

  def update
    order = Order.find(params[:id])
    voucher = order.prepare_voucher
    order.apply_voucher(voucher)
    redirect_to :back
  end

end
