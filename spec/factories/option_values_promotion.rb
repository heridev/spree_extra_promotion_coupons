FactoryGirl.define do
  factory :promotional_code_with_option_values, class: Spree::Promotion do
    name 'august promo'
    description 'description code'
    code 'august_code'
    starts_at 1.day.ago

    after(:create) do |promotion|
      product = FactoryGirl.create :promotional_product
      calculator = Spree::Calculator::ProductWithOptionValueCalculator.new
      action = Spree::Promotion::Actions::ProductWithOptionValueAction.new
      rule = Spree::Promotion::Rules::ProductWithOptionValueRule.new
      option_values = product.variants.first.option_values
      calculator.preferred_product_price = 50
      calculator.save
      action.calculator = calculator
      action.save
      rule.option_values << option_values
      rule.save
      promotion.rules << rule
      promotion.actions << action
    end

  end
end
