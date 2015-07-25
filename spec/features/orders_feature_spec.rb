require 'rails_helper'

feature 'A user on the home page' do

  before(:each) do
    Product.create(name: 'Black Shoes', category: "Men's Footwear")
    visit '/'
  end

  scenario 'sees a list of all products' do
    expect(page).to have_content "Black Shoes - Men's Footwear"
  end

end
