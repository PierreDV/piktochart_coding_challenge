# Piktochart Coding Challenge

Peter de Verteuil's submission for the **Acme Widget Co** coding challenge.

## Installation and Testing Instructions

You’ll need to have **Ruby** installed on your system. This project requires **Ruby version 2.7 or newer** to run the tests.

To install and test, run the following commands in your terminal:

```
git clone git@github.com:PierreDV/piktochart_coding_challenge.git
cd piktochart_coding_challenge
ruby basket_test.rb
```

This will execute the included Minitest suite and verify that the basket logic works as expected.

## How It Works

The core logic is contained within the `Basket` class.

`Basket` instances are initialized with three inputs:
- a **product catalogue** (array of hashes containing product codes and prices).
- a set of **delivery charge rules**.
- a list of **offers**.

### `Basket` Class

The basket exposes two main methods:

- `add(product_code)` – adds an item to the basket if the product code exists in the catalogue. 
  If an invalid code is supplied, it raises an `ArgumentError`.

- `total` – calculates the overall cost of the basket by:
  1. Calculating the subtotal of all items.
  2. Applying any discounts from active offers.
  3. Determining the appropriate delivery charge based on the **discounted total**.
  4. Returning the final total, formatted as a USD currency string.

### `Offers` Module

The `Offers` module contains special pricing rules that can be extended by adding new classes.

An included example offer is the `BuyOneGetSecondHalfPrice` class.
This class can be initialized with a specific `product_code` (e.g. `'R01'`) and includes an `apply` method which:
- counts how many of that product are in the basket,
- determines how many “pairs” exist, and
- applies a 50% discount to one item in each pair.

For example:
- Buy 2 red widgets → 1 half price  
- Buy 4 red widgets → 2 half price

## Assumptions Made

- Discounts are applied **before** calculating delivery charges.
- Totals are always **rounded down** to two decimal places.
- Output of `total` is always formatted into USD currency.
- The buy-one-get-second-half-price offer applies **per pair** of items.
  (e.g. 3 red widgets → 1 discounted, 4 red widgets → 2 discounted).
- The basket expects `catalogue` and `delivery_charge_rules` to be provided at initialization, and for `offers` to be an optional argument.

## Example Usage

```ruby
basket = Basket.new(
  catalogue: [
    { product_code: 'R01', price: 32.95 },
    { product_code: 'G01', price: 24.95 },
    { product_code: 'B01', price: 7.95 }
  ],
  delivery_charge_rules: [
    { cost_under: 50, charge: 4.95 },
    { cost_under: 90, charge: 2.95 }
  ],
  offers: [Offers::BuyOneGetSecondHalfPrice.new(product_code: 'R01')]
)

basket.add('R01')
basket.add('R01')
puts basket.total # => "$54.37"
```
