module Spree
  Shipment.class_eval do
    #From Spree 2.2
    def set_up_inventory(state, variant, order, line_item)
      self.inventory_units.create(
        state: state,
        variant_id: variant.id,
        order_id: order.id,
        line_item_id: line_item.id
      )
    end
  end
end
