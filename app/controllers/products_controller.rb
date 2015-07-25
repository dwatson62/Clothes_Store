class ProductsController < ApplicationController

  def update
    product = Product.find(params[:id])
    product.quantity -= 1
    product.save
    order = Order.find(params[:order_id])
    order.products << product
    order.remove_discounts
    redirect_to '/'
  end

  def destroy
    product = Product.find(params[:id])
    product.quantity += 1
    product.save
    order = Order.find(params[:order_id])
    order.remove_discounts
    order.products.delete(product)
    redirect_to '/'
  end

end
