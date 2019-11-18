require 'rails_helper'

RSpec.describe Product, type: :model do
  # subject { described_class.new }
  describe 'Validations' do
    it 'validates a 4 field product' do
      # @categoy = Category.new(id: 1, name: "Electronics", created_at: DateTime.now, updated_at: DateTime.now)
      @categoy = Category.new(id: 1, name: "Electronics")
      @categoy.save!
      #   @product = Product.new(id: 1, name: "Name", description: "Description", image: 'apparel4.jpg', price_cents: 4563, quantity: 1, created_at: DateTime.now, updated_at: DateTime.now, category_id: 1)
      @product = Product.new(id: 1, name: "TV", description: "Awesome TV set", image: 'apparel4.jpg', price_cents: 4563, quantity: 1, category_id: 1)
      @product.save!
      expect(@product).to be_valid
    end
    it 'validates name presence' do
      @categoy = Category.new(id: 1, name: "Electronics")
      @categoy.save!
      @product = Product.new(id: 1, name: nil, description: "Awesome TV set", image: 'apparel4.jpg', price_cents: 4563, quantity: 1, category_id: 1)
      expect(@product).not_to be_valid
    end
    it 'validates price presence' do
      @categoy = Category.new(id: 1, name: "Electronics")
      @categoy.save!
      @product = Product.new(id: 1, name: "TV", description: "Awesome TV set", image: 'apparel4.jpg', price_cents: nil, quantity: 1, category_id: 1)
      expect(@product).not_to be_valid
    end
    it 'validates quantity presence' do
      @categoy = Category.new(id: 1, name: "Electronics")
      @categoy.save!
      @product = Product.new(id: 1, name: "TV", description: "Awesome TV set", image: 'apparel4.jpg', price_cents: 4563, quantity: nil, category_id: 1)
      expect(@product).not_to be_valid
    end
    it 'validates categoy presence' do
      @categoy = Category.new(id: 1, name: "Electronics")
      @categoy.save!
      @product = Product.new(id: 1, name: "TV", description: "Awesome TV set", image: 'apparel4.jpg', price_cents: 4563, quantity: 1, category_id: nil)
      expect(@product).not_to be_valid
    end
  end
end
