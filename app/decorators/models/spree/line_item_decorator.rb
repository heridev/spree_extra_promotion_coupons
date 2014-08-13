Spree::LineItem.class_eval do
  has_many :option_values, through: :variant
end

