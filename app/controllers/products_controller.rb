class ProductsController < ApplicationController

  def update
    product = Product.find(params[:id])
    product.quantity -= 1
    product.save
    order = Order.find(params[:id])
    order.products << product
    redirect_to '/'
  end

end
