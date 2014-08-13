module Spree
  class Promotion
    module Actions
      class ProductWithOptionValueAction < Spree::PromotionAction

        delegate :eligible?, to: :promotion

        include Spree::Core::CalculatedAdjustments

        has_many :adjustments, as: :source

        before_validation :ensure_action_has_calculator

        def perform(payload = {})
          order = payload[:order]
          result = false

          items = get_line_items_with_discount(order)

          items.find_each do |line_item|
            current_result = create_adjustment(line_item, order)
            result ||= current_result
          end

          return result
        end

        def compute_amount(calculable)
          amount = self.calculator.compute(calculable).to_f.abs
          amount * -1
        end

        private

          def create_adjustment(adjustable, order)
            amount = self.compute_amount(adjustable)
            return if amount == 0
            return if promotion.product_ids.present? and !promotion.product_ids.include?(adjustable.product.id)
            self.adjustments.create!(
              amount: amount,
              adjustable: adjustable,
              order: order,
              label: promotion_name,
            )
            true
          end

          def promotion_name
            self.promotion.name
          end

          def get_line_items_with_discount(order)
            already_adjusted_line_items = [0] + self.adjustments.pluck(:adjustable_id)
            Spree::LineItem.joins(:option_values)
                            .where('spree_option_values.id in (?)
                                    AND
                                    order_id = ?
                                    AND
                                    spree_line_items.id NOT IN (?)',
                                    get_option_values_with_discount,
                                    order.id,
                                    already_adjusted_line_items)

          end

          def get_option_values_with_discount
            rule_name = 'Spree::Promotion::Rules::ProductWithOptionValueRule'
            promotion_rule = self.promotion.rules.find_by(type: rule_name)
            promotion_rule.option_values.map(&:id).uniq
          end

          def promotion_credit_exists?(adjustable)
            self.adjustments.where(order_id: adjustable.id).exists?
          end

          def ensure_action_has_calculator
            return if self.calculator
            self.calculator = Calculator::ProductWithOptionValueCalculator.new
          end
      end
    end
  end
end

