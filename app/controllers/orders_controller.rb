class OrdersController < ApplicationController

  def index
    @order = Order.first_or_create
    @products = Product.all
  end

end
