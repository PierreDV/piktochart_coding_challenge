# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'basket'

describe 'Basket' do
  def setup
    @catalogue = [
      { product_code: 'R01', price: 32.95 },
      { product_code: 'G01', price: 24.95 },
      { product_code: 'B01', price: 7.95 }
    ]
    @basket = Basket.new(catalogue: @catalogue)
  end

  describe '#initialize' do
    it 'initializes with an empty basket' do
      _(@basket.items).must_equal []
    end
  end

  describe '#add' do
    it 'adds a product to the basket' do
      @basket.add('B01')
      _(@basket.items).must_equal ['B01']
    end

    it 'raises an error if product code is not included in catalogue' do
      error = _ { @basket.add('NOGOOD') }.must_raise ArgumentError
      _(error.message).must_equal 'Product code NOGOOD is not included in the catalogue.'
    end
  end
end
