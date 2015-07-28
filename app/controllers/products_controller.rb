class ProductsController < ApplicationController

  def update
    product = Product.find(params[:id])
    product.add_item_decrease_quantity
    order = Order.find(params[:order_id])
    order.products << product
    order.remove_discounts
    redirect_to :back
  end

  def destroy
    product = Product.find(params[:id])
    product.remove_item_increase_quantity
    order = Order.find(params[:order_id])
    order.remove_discounts
    order.products.delete(product)
    redirect_to :back
  end

end
