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

  private

  def valid_product_code?(product_code)
    catalogue.any? { |catalogue_item| catalogue_item[:product_code] == product_code }
  end
end
