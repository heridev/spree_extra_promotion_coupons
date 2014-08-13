module Spree
  class Calculator::ProductWithOptionValueCalculator < Calculator
    preference :product_price, :decimal, default: 0

    def self.description
      'Change Product price'
    end

    def compute(line_item = nil)
      discount = line_item.quantity * preferred_product_price
      (line_item.price * line_item.quantity) - discount
    end
  end
end

