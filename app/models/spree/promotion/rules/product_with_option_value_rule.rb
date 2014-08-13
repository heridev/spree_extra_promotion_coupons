module Spree
  class Promotion
    module Rules
      class ProductWithOptionValueRule < PromotionRule

        has_and_belongs_to_many :option_values, class_name: '::Spree::OptionValue', join_table: 'spree_option_values_promotion_rules', foreign_key: 'promotion_rule_id'

        def applicable?(promotable)
          promotable.is_a?(Spree::Order)
        end

        def eligible?(order, options = {})
          option_values_ids = option_values.map(&:id).uniq
          items = Spree::LineItem.joins(:option_values)
                                  .where('spree_option_values.id in (?) AND order_id = ?',
                                          option_values_ids, order.id)
          items.any?
        end

        def option_value_ids_string
          option_values.pluck(:id).join(',')
        end

        def option_value_ids_string=(s)
          ids = s.to_s.split(',').map(&:strip)
          self.option_values = Spree::OptionValue.find(ids)
        end
      end
    end
  end
end

