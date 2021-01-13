require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
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

    scenario "They go to first product's details page" do
      # Go to home
      visit root_path

      # Locate first product and click Details button
      first("article.product").find('.pull-right').click
      
      # Check if we are on the product's details page by looking for these detail headers
      expect(page).to have_content "Name"
      expect(page).to have_content "Description"
      expect(page).to have_content "Quantity"
      expect(page).to have_content "Price"

      save_screenshot

    end
end
