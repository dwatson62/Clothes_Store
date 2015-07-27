require 'rails_helper'

feature 'A user arrives on the home page for the first time' do

  before(:each) do
    Product.create(name: 'Black Shoes', category: "Men's Footwear", quantity: 2, price: 9.99)
    Product.create(name: 'Black Tie', category: "Men's Formalwear", quantity: 0, price: 15.99)
    visit '/'
  end

  let! (:order) { Order.first }

  scenario 'sees a list of all products' do
    expect(page).to have_content "Men's Footwear Black Shoes $9.99"
  end

  scenario 'starts with an empty shopping cart' do
    expect(page).to have_content 'Empty!'
  end

  scenario 'can add an item to the shopping cart' do
    click_on 'Add to cart'
    expect(page).to have_content 'Shopping cart: 1x Black Shoes $9.99'
    expect(page).not_to have_content 'Empty!'
    expect(order.products.length).to eq 1
  end

  scenario 'cannot order an item that is out of stock' do
    Product.first.destroy
    visit '/'
    expect(page).to have_content "Men's Formalwear Black Tie $15.99 Out of Stock"
  end

end

feature 'A user while shopping' do

  before(:each) do
    product = Product.create(name: 'Black Shoes', category: "Men's Footwear", quantity: 2, price: 9.99)
    visit '/'
    click_on 'Add to cart'
  end

  scenario 'displays current shopping cart' do
    expect(page).to have_content 'Shopping cart: 1x Black Shoes $9.99'
    expect(page).not_to have_content 'Empty!'
  end

  scenario 'when last of a product is ordered, it is displayed as out of stock' do
    expect(page).to have_content "Men's Footwear Black Shoes $9.99"
    click_on 'Add to cart'
    expect(page).to have_content "Men's Footwear Black Shoes $9.99 Out of Stock"
  end

  scenario 'can remove a product from the cart' do
    click_on 'Remove item'
    expect(page).not_to have_content '1x Black shoes $9.99'
    expect(page).to have_content 'Empty!'
  end

  scenario 'can view total price of order' do
    expect(page).to have_content 'Total: $9.99'
  end

end
