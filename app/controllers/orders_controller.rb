class OrdersController < ApplicationController

  include ActionView::Helpers::NumberHelper

  def index
    @order = Order.first_or_create
    @products = Product.all
    @total = @order.products.sum(:price)
    @total = number_to_currency(@total)

  end

end
