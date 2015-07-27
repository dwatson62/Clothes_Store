class OrdersController < ApplicationController

  include ActionView::Helpers::NumberHelper

  def index
    @order = Order.first_or_create
    @categories = Product.all.order(category: :desc).map { |p| p.category }.uniq
    if params[:category]
      @products = Product.all.where(category: params[:category])
    elsif @order.products.length > 0
      previous_category = @order.products.last.category
      @products = Product.all.where(category: previous_category)
    else
      default_category = Product.first.category
      @products = Product.all.where(category: default_category)
    end
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
