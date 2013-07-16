Spree::InventoryUnit.class_eval do
  def self.destroy_units(order, variant, quantity)
    variant_units = order.inventory_units.group_by(&:variant_id)
    return unless variant_units.include? variant.id

    variant_units = variant_units[variant.id].reject do |variant_unit|
      variant_unit.state == 'shipped'
    end.sort_by(&:state)

    quantity.times do
      inventory_unit = variant_units.shift
      if !inventory_unit.nil?
        inventory_unit.destroy
      end
    end
  end
end
