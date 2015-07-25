require 'rails_helper'

feature 'A user arrives on the home page for the first time' do

  before(:each) do
    Product.create(name: 'Black Shoes', category: "Men's Footwear", quantity: 2)
    Product.create(name: 'Black Tie', category: "Men's Formalwear", quantity: 0)
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

  scenario 'cannot order an item that is out of stock' do
    expect(page).to have_content "Black Tie - Men's Formalwear Out of Stock"
  end

end

feature 'A user while shopping' do

  before(:each) do
    product = Product.create(name: 'Black Shoes', category: "Men's Footwear", quantity: 2, price: 9.99)
    visit '/'
    click_on 'Add to cart'
  end

  scenario 'displays current shopping cart' do
    expect(page).to have_content 'Shopping cart: Black Shoes'
    expect(page).not_to have_content 'Empty!'
  end

  scenario 'when last of a product is ordered, it is displayed as out of stock' do
    expect(page).to have_content "Black Shoes - Men's Footwear"
    click_on 'Add to cart'
    expect(page).to have_content "Black Shoes - Men's Footwear Out of Stock"
  end

  scenario 'can remove a product from the cart' do
    click_on 'Remove item'
    expect(page).not_to have_content 'Black shoes'
    expect(page).to have_content 'Empty!'
  end

  scenario 'can view total price of order' do
    expect(page).to have_content 'Total: $9.99'
  end

end

feature 'Vouchers' do

  before(:each) do
    product = Product.create(name: 'Black Shoes', category: "Men's Footwear", quantity: 2, price: 9.99)
    visit '/'
    click_on 'Add to cart'
  end

  scenario 'Displays available vouchers' do
    expect(page).to have_content 'Available vouchers: '
  end

  scenario 'Can apply a $5.00 discount to the order' do
    expect(page).to have_content 'Total: $9.99'
    click_on '$5.00 discount'
    expect(page).to have_content 'Total: $4.99'
  end

end