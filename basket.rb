# frozen_string_literal: true

class Basket
  attr_reader :items

  def initialize
    @items = []
  end

  def add(product_code)
    items << product_code
  end
end
