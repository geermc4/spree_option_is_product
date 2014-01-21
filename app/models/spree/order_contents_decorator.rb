Spree::OrderContents.class_eval do

  def add(variant, quantity=1, currency=nil, shipment=nil, price=nil, parent_id=nil)
    line_item = parent_id ? nil : order.find_line_item_by_variant(variant)
    add_to_line_item(line_item, variant, quantity, currency, shipment, price, parent_id)
  end

  # Override from spree's original method to add the `price` argument passed by `add`
  def add_to_line_item(line_item, variant, quantity, currency=nil, shipment=nil, price=nil, parent_id=nil)
    if line_item
      line_item.target_shipment = shipment
      line_item.quantity += quantity.to_i
      line_item.currency = currency unless currency.nil?
      line_item.save
    else
      line_item = order.line_items.new(variant: variant)
      line_item.quantity = quantity
      line_item.target_shipment = shipment
      line_item.variant = variant
      line_item.parent_id = parent_id
      if currency
        line_item.currency = currency unless currency.nil?
        line_item.price    = price || variant.price_in(currency).amount
      else
        line_item.price    = price || variant.price
      end
    end
    line_item.save
    order.reload
    line_item
  end

  # Override from spree to add `line_item` arg.
  # Since spree 2.2 the inventory_unit is associated to the line_item
  # so no need to "find" it if present
  def remove(variant, quantity = 1, shipment = nil, line_item = nil)
    line_item = line_item || order.find_line_item_by_variant(variant)

    unless line_item
      raise ActiveRecord::RecordNotFound, "Line item not found for variant #{variant.sku}"
    end

    remove_from_line_item(line_item, variant, quantity, shipment)
  end

end