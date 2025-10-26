# frozen_string_literal: true

class Basket
  attr_reader :catalogue, :delivery_charge_rules, :items, :offers

  def initialize(catalogue:, delivery_charge_rules:, offers:)
    @catalogue = catalogue
    @delivery_charge_rules = delivery_charge_rules.sort_by { |charge_rule| charge_rule[:cost_under] }
    @items = []
    @offers = offers
  end

  def add(product_code)
    unless valid_product_code?(product_code)
      raise ArgumentError, "Product code #{product_code} is not included in the catalogue."
    end

    items << product_code
  end

  def total
    subtotal = items.sum { |item| price_for(item) }
    discounted_subtotal = subtotal - discount
    (discounted_subtotal + delivery_charge(discounted_subtotal)).floor(2)
  end

  private

  def delivery_charge(items_total)
    applicable_rule = delivery_charge_rules.find { |rule| items_total < rule[:cost_under] }
    applicable_rule ? applicable_rule[:charge] : 0
  end

  def discount
    offers.sum { |offer| offer.apply(catalogue: catalogue, items: items) }
  end

  def valid_product_code?(product_code)
    catalogue.any? { |catalogue_item| catalogue_item[:product_code] == product_code }
  end

  def price_for(product_code)
    catalogue.find { |catalogue_item| catalogue_item[:product_code] == product_code }[:price]
  end
end
