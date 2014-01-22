Spree::InventoryUnit.class_eval do
  belongs_to :line_item, class_name: "Spree::LineItem", inverse_of: :inventory_units
end
