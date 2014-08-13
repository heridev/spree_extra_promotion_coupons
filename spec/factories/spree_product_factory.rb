FactoryGirl.define do
  factory :promotional_product, class: Spree::Product do
    name          'Bearing'
    description   'Bearing description'
    price         199.99
    cost_price    170.0
    sku           'ABC'
    available_on  { 1.year.ago }
    deleted_at    nil

    shipping_category { |r| Spree::ShippingCategory.first || r.association(:shipping_category) }

    after(:create) do |product|
      product.variants << create(:product_variant_black, price: product.price)
    end
  end
end
