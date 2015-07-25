require 'rails_helper'

feature 'Vouchers' do

  before(:each) do
    product = Product.create(name: 'Black Shoes', category: "Men's Footwear", quantity: 2, price: 9.99)
    visit '/'
    click_on 'Add to cart'
  end

  let! (:order) { Order.first }

  scenario 'Displays available voucher' do
    expect(page).to have_content 'Available voucher: '
  end

  scenario 'Can apply a $5.00 discount to the order' do
    expect(page).to have_content 'Total: $9.99'
    expect(page).not_to have_button '$10 off when you spend over $50.00'
    click_on '$5 off your order'
    expect(page).to have_content 'Discount: $5.00'
  end

  scenario 'Applies $5 discount to final total' do
    expect(page).to have_content 'Total: $9.99'
    click_on '$5 off your order'
    expect(page).to have_content 'Total: $4.99'
  end

  scenario 'Can apply a $10.00 discount to an over $50 order' do
    product = Product.create(name: 'Black Jacket', category: "Men's Formalwear", quantity: 2, price: 49.99)
    order.products << product
    visit '/'
    expect(page).to have_content 'Total: $59.98'
    expect(page).not_to have_button '$5 off your order'
    click_on '$10 off when you spend over $50.00'
    expect(page).to have_content 'Discount: $10.00'
    expect(page).to have_content 'Total: $49.98'
  end

  scenario 'Applies $10 discount to final total' do
    product = Product.create(name: 'Black Jacket', category: "Men's Formalwear", quantity: 2, price: 49.99)
    order.products << product
    visit '/'
    expect(page).to have_content 'Total: $59.98'
    click_on '$10 off when you spend over $50.00'
    expect(page).to have_content 'Total: $49.98'
  end

  scenario 'Removing an item from the cart also removes applied voucher' do
    click_on 'Add to cart'
    click_on '$5 off your order'
    expect(page).to have_content 'Discount: $5.00'
    click_on 'Remove item'
    expect(page).not_to have_content 'Discount: $5.00'
  end

end
