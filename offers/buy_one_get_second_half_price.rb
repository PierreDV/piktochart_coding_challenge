# frozen_string_literal: true

module Offers
  class BuyOneGetSecondHalfPrice
    attr_reader :product_code

    def initialize(product_code:)
      @product_code = product_code
    end

    def apply(catalogue:, items:)
      count = items.count(product_code)
      pairs = count / 2
      return 0 if pairs.zero?

      price = catalogue.find { |entry| entry[:product_code] == product_code }[:price]
      pairs * (price / 2)
    end
  end
end
