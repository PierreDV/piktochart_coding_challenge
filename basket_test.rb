# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'basket'
require_relative 'offers/buy_one_get_second_half_price'

describe 'Basket' do
  def new_basket
    catalogue = [
      { product_code: 'R01', price: 32.95 },
      { product_code: 'G01', price: 24.95 },
      { product_code: 'B01', price: 7.95 }
    ]

    delivery_charge_rules =
      [
        { cost_under: 50, charge: 4.95 },
        { cost_under: 90, charge: 2.95 }
      ]

    offers = [Offers::BuyOneGetSecondHalfPrice.new(product_code: 'R01')]

    Basket.new(
      catalogue: catalogue,
      delivery_charge_rules: delivery_charge_rules,
      offers: offers
    )
  end

  def basket_with_items(items)
    basket = new_basket
    items.each { |item| basket.add(item) }
    basket
  end

  describe '#initialize' do
    it 'initializes with an empty basket' do
      basket = new_basket
      _(basket.items).must_equal []
    end
  end

  describe '#add' do
    it 'adds a product to the basket' do
      basket = new_basket
      basket.add('B01')
      _(basket.items).must_equal ['B01']
    end

    it 'raises an error if product code is not in catalogue' do
      basket = new_basket
      error = _ { basket.add('NOGOOD') }.must_raise ArgumentError
      _(error.message).must_equal 'Product code NOGOOD is not included in the catalogue.'
    end
  end

  describe '#total' do
    it 'calculates total for blue and green widget with delivery' do
      basket = basket_with_items(%w[B01 G01])
      _(basket.total).must_equal 37.85
    end

    it 'calculates total with buy one get second half price offer' do
      basket = basket_with_items(%w[R01 R01])
      _(basket.total).must_equal 54.37
    end

    it 'calculates total for red and green widget with reduced delivery' do
      basket = basket_with_items(%w[R01 G01])
      _(basket.total).must_equal 60.85
    end

    it 'calculates total with multiple discounts and free delivery' do
      basket = basket_with_items(%w[B01 B01 R01 R01 R01])
      _(basket.total).must_equal 98.27
    end
  end
end
