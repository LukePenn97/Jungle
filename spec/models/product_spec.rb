require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    name = "Big Table"
    category_id = 1
    quantity = 5
    price = 10000
    it 'should create a new valid product' do
      category = Category.create({name: "some_category"})
      product = Product.new({name: name, category_id: category.id, quantity: quantity, price: price})
      expect(product.valid?).to be true
    end
    it "should return an error when name is nil" do
      category = Category.create({name: "some_category"})
      product = Product.new({name: nil, category_id: category.id, quantity: quantity, price: price})
      expect(product.errors.full_messages.first).to eq "Name can't be blank"
    end
    it "should return an error when category is nil" do
      category = Category.create({name: "some_category"})
      product = Product.new({name: name, category_id: nil, quantity: quantity, price: price})
      expect(product.errors.full_messages.first).to eq "Category can't be blank"
    end
    it "should return an error when quantity is nil" do
      category = Category.create({name: "some_category"})
      product = Product.new({name: name, category_id: category.id, quantity: nil, price: price})
      expect(product.errors.full_messages.first).to eq "Quantity can't be blank"
    end
    it "should return an error when price is nil" do
      category = Category.create({name: "some_category"})
      product = Product.new({name: name, category_id: category.id, quantity: quantity, price: "nil"})
      expect(product.errors.full_messages.first).to eq "Price is not a number"
    end

  end
end
