require 'rails_helper'

feature 'A user arrives on the home page for the first time' do

  before(:each) do
    Product.create(name: 'Black Shoes', category: "Men's Footwear", quantity: 1)
    visit '/'
  end

  scenario 'sees a list of all products' do
    expect(page).to have_content "Black Shoes - Men's Footwear"
  end

  scenario 'starts with an empty shopping cart' do
    expect(page).to have_content 'Empty!'
  end

  scenario 'can add an item to the shopping cart' do
    order = Order.first
    click_on 'Add to cart'
    expect(page).to have_content 'Shopping cart: Black Shoes'
    expect(page).not_to have_content 'Empty!'
    expect(order.products.length).to eq 1
  end

end

feature 'A user while shopping' do

  before(:each) do
    product = Product.create(name: 'Black Shoes', category: "Men's Footwear", quantity: 1)
    order = Order.create
    order.products << product
    visit '/'
  end

  scenario 'displays current shopping cart' do
    expect(page).to have_content 'Shopping cart: Black Shoes'
    expect(page).not_to have_content 'Empty!'
  end

  scenario 'can remove a product from the cart' do
    click_on 'Remove item'
    expect(page).not_to have_content 'Black shoes'
    expect(page).to have_content 'Empty!'
  end

end