FactoryGirl.define do
  factory :color_black, class: Spree::OptionValue do
    position 1
    name "color-black"
    presentation "Black"

    association :option_type, factory: :option_type_color
  end

  factory :blue_water, class: Spree::OptionValue do
    position 2
    name "blue water"
    presentation "Blue Water"

    association :option_type, factory: :option_type_material
  end
end

