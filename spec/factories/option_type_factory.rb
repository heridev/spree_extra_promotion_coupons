FactoryGirl.define do
  factory :option_type_color, class: Spree::OptionType do
    name 'color'
    presentation 'color'
  end

  factory :option_type_material, class: Spree::OptionType do
    name 'name type'
    presentation 'presentation type'
  end
end
