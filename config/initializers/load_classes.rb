Rails.application.config.spree.promotions.actions << Spree::Promotion::Actions::ProductWithOptionValueAction
Rails.application.config.spree.promotions.rules << Spree::Promotion::Rules::ProductWithOptionValueRule
Rails.application.config.spree.calculators.promotion_actions_create_adjustments << Spree::Calculator::ProductWithOptionValueCalculator

