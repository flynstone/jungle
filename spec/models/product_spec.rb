require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    describe 'Product' do
      it 'should save if all fields are valid' do
        @category = Category.new(name: "books")
        @product = Product.new(name: "The girl with the dragon tattoo", price_cents: 1999, quantity: 1, category_id:@category.id)
        @product.save

        expect(@product.name).to eq("The girl with the dragon tattoo")
        expect(@product.price_cents).to eq(1999)
        expect(@product.quantity).to eq(1)
        expect(@product.category_id).to eq(@category.id)
    end
  end

    # validates :name, presence: true
    describe 'Product' do 
      it 'should validate name not empty' do
        @category = Category.new(name: "books")
        @product = Product.new(name: nil, price_cents: 1999, quantity: 1, category_id:@category.id)
        @product.save

        expect(@product.errors.full_messages).to include("Name can't be blank")
      end
    end

    # validates :price, presence: true 
    describe 'Product' do 
      it 'should validate price not empty' do
        @category = Category.new(name: "books")
        @product = Product.new(name: "The girl with the dragon tattoo", price_cents: nil, quantity: 1, category_id:@category.id)
        @product.save

        expect(@product.errors.full_messages).to include("Price is not a number")
      end
    end

    # validates :quantity, presence: true
    describe 'Product' do 
      it 'should validate quantity not empty' do
        @category = Category.new(name: "books")
        @product = Product.new(name: "The girl with the dragon tattoo", price_cents: 1999, quantity: nil, category_id:@category.id)
        @product.save

        expect(@product.errors.full_messages).to include("Quantity can't be blank")
      end
    end

    # validates :category, presence: true
    describe 'Product' do 
      it 'should validate category not empty' do
        @category = Category.new(name: "books")
        @product = Product.new(name: "The girl with the dragon tattoo", price_cents: 1999, quantity: 1, category_id: nil)
        @product.save

        expect(@product.errors.full_messages).to include("Category can't be blank")
      end
    end
  end
end
