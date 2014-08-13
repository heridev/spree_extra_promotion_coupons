require 'spec_helper'

describe Spree::Promotion::Rules::ProductWithOptionValueRule do
  let!(:promotion) { FactoryGirl.create :promotional_code_with_option_values }
  let(:rule) { promotion.rules.first }
  let(:order) { Spree::Order.new }
  let(:order_without_valid_items) { create(:order_with_line_items, :line_items_count => 1) }

  before do
    option_value = Spree::OptionValue.find_by(name: 'blue water').variants.first
    order.line_items << create(:line_item, variant: option_value, price: 200)
    order.save
    order.line_items.reload
    order.update!
  end

  it "should be eligible if the order contain product with promotional option values" do
    expect(rule.eligible?(order)).to be_truthy
  end

  it "should not be eligible the order" do
    expect(rule.eligible?(order_without_valid_items)).to be_falsey
  end
end

