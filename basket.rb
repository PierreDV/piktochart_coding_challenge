# frozen_string_literal: true

class Basket
  attr_reader :catalogue, :items

  def initialize(catalogue:)
    @catalogue = catalogue
    @items = []
  end

  def add(product_code)
    unless valid_product_code?(product_code)
      raise ArgumentError, "Product code #{product_code} is not included in the catalogue."
    end

    items << product_code
  end

  def total
    items.sum { |item| price_for(item) }.floor(2)
  end

  private

  def valid_product_code?(product_code)
    catalogue.any? { |catalogue_item| catalogue_item[:product_code] == product_code }
  end

  def price_for(product_code)
    catalogue.find { |catalogue_item| catalogue_item[:product_code] == product_code }[:price]
  end
end
