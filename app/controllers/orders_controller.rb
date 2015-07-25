class OrdersController < ApplicationController

  def index
    @order = Order.new
    @products = Product.all
  end

end
