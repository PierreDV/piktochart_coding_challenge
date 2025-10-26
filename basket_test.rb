# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'basket'

describe 'Basket' do
  def setup
    @basket = Basket.new
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
  end
end
