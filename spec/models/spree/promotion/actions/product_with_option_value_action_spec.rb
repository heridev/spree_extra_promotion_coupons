require 'spec_helper'

describe Spree::Promotion::Actions::ProductWithOptionValueAction do
  let!(:promotion) { FactoryGirl.create :promotional_code_with_option_values }
  let(:order) { Spree::Order.new }
  let(:order_without_valid_items) { create(:order_with_line_items, :line_items_count => 1) }

  before do
    option_value = Spree::OptionValue.find_by(name: 'blue water').variants.first
    order.line_items << create(:line_item, variant: option_value, price: 200)
    order.save
    order.line_items.reload
    order.update!
  end

  it 'returns the amount of the discount' do
    action = promotion.actions.first
    expect(action.compute_amount(order.line_items.first)).to eq(-150.0)
  end

  it 'applies the discount when the perform action is invoked' do
    expect(order.total).to eq 200.0
    expect(promotion.actions.first.perform(order: order)).to be_truthy
    expect(promotion.credits_count).to eq 1
    order.update!
    expect(order.total).to eq 50.0
  end

  it 'does not apply the perform action' do
    expect(order_without_valid_items.total.to_s).to eq '110.0'
    expect(promotion.actions.first.perform(order: order_without_valid_items)).to be_falsey
    expect(promotion.credits_count).to eq 0
    order_without_valid_items.update!
    expect(order_without_valid_items.total.to_s).to eq '110.0'
  end
end
