require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
    # SETUP
    before :each do
      @category = Category.create! name: 'Apparel'
  
      10.times do |n|
        @category.products.create!(
          name:  Faker::Hipster.sentence(3),
          description: Faker::Hipster.paragraph(4),
          image: open_asset('apparel1.jpg'),
          quantity: 10,
          price: 64.99
        )
      end
    end

    scenario "They add a product to the cart" do
      # Go to home
      visit root_path

      # Check if cart currently has 0 products
      expect(page).to have_content "My Cart (0)"

      # Locate first product and click Details button
      first("article.product").find_button('Add').click

      # Check if cart has changed from 0 to 1 and click
      find_link('My Cart (1)').click
      
      # Check if we are on the cart checkout page
      expect(page).to have_content "TOTAL:"

    end
end
