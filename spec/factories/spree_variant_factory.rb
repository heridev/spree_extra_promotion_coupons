FactoryGirl.define do

  factory :product_variant, class: Spree::Variant do
    price 19.99
    cost_price 17.00
    sku    { SecureRandom.hex }
    is_master 0
    track_inventory true

    association :product

    before(:create) { create(:stock_location) if Spree::StockLocation.count == 0 }

  end

  factory :product_variant_black, parent: :product_variant do
    option_values { [create(:color_black), create(:blue_water)] }
  end
end

