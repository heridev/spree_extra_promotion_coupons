class CreateSpreeOptionValuesPromotionRules < ActiveRecord::Migration
  def change
    create_table :spree_option_values_promotion_rules do |t|
      t.references :option_value
      t.references :promotion_rule
    end

    add_index :spree_option_values_promotion_rules, [:option_value_id], :name => 'index_option_values_promotion_rules_on_option_value_id'
    add_index :spree_option_values_promotion_rules, [:promotion_rule_id], :name => 'index_option_values_promotion_rules_on_promotion_rule_id'
  end
end

