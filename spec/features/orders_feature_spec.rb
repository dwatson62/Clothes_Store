require 'rails_helper'

feature 'A user on the home page' do

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
    click_on 'Add to cart'
    expect(page).to have_content 'Black Shoes'
    expect(page).not_to have_content 'Empty!'
  end

end
