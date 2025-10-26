# frozen_string_literal: true

module Offers
  class BuyOneGetSecondHalfPrice
    attr_accessor :product_code

    def initialize(product_code:)
      @product_code = product_code
    end

    def apply(catalogue:, items:)
      count = items.count(product_code)
      pairs = count / 2
      return 0 if pairs.zero?

      product = catalogue.find { |entry| entry[:product_code] == product_code }
      return 0 unless product

      pairs * (product[:price] / 2)
    end
  end
end
