class ProductsController < ApplicationController

  def update
    product = Product.find(params[:id])
    product.quantity -= 1
    product.save
    order = Order.find(params[:order_id])
    order.products << product
    redirect_to '/'
  end

  def destroy
    product = Product.find(params[:id])
    product.quantity += 1
    product.save
    order = Order.find(params[:order_id])
    index = order.products.find(product.id)
    order.products.delete(product)
    redirect_to '/'
  end

end
