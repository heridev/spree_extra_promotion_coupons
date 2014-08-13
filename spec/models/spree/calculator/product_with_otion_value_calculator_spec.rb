require 'spec_helper'

describe Spree::Calculator::ProductWithOptionValueCalculator do
  let(:calculator) { subject }
  let!(:promotion) { FactoryGirl.create :promotional_code_with_option_values }
  let(:order) { Spree::Order.new }

  before do
    option_value = Spree::OptionValue.find_by(name: 'blue water').variants.first
    order.line_items << create(:line_item, variant: option_value, price: 200)
    order.save
    order.line_items.reload
    order.update!
  end

  it 'returns the amount used for the discount' do
    calculator = promotion.actions.first.calculator
    line_item = order.line_items.first
    expect(calculator.compute(line_item)).to eq 150
  end
end

