require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it 'should save with all 4 fields provided' do
      category = Category.create(name: 'Root Vegetables')
      product = Product.create(
        name: 'Potato',
        price: 2000,
        quantity: 10,
        category: category,
      )
      expect(product).to be_valid
    end

    it 'should return an error if name is nil' do
      category = Category.create(name: 'Root Vegetables')
      product = Product.new
      product.name = nil
      product.price = 1
      product.quantity = 2
      product.category = category
      product.save
      expect(product.errors.full_messages).to include("Name can't be blank") 
    end

    it 'should return an error if price is nil' do
      category = Category.create(name: 'Root Vegetables')
      product = Product.new
      product.name = 'Yam'
      product.price = nil
      product.quantity = 2
      product.category = category
      product.save
      expect(product.errors.full_messages).to include("Price can't be blank") 
    end

    it 'should return an error if quantity is nil' do
      category = Category.create(name: 'Root Vegetables')
      product = Product.new
      product.name = 'Carrot'
      product.price = 1
      product.quantity = nil
      product.category = category
      product.save
      expect(product.errors.full_messages).to include("Quantity can't be blank") 
    end
    
    it 'should return an error if category is nil' do
      category = Category.create(name: 'Root Vegetables')
      product = Product.new
      product.name = 'Beet'
      product.price = 2
      product.quantity = 2
      product.category = nil
      product.save
      expect(product.errors.full_messages).to include("Category can't be blank") 
    end

  end
end
