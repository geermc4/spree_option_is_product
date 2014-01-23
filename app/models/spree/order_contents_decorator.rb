Spree::OrderContents.class_eval do
  def add(variant, quantity=1, currency=nil, shipment=nil, price=nil, parent_id=nil, options=[])
    line_item = parent_id ? nil : order.find_line_item_by_variant(variant)
    li = add_to_line_item(line_item, variant, quantity, currency, shipment, price, parent_id)
    add_options(options,li,currency,shipment) unless options.blank?
    li #just incase the return value matters somewhere
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

    # If removing the item success then proceed to remove children (parts)
    if remove_from_line_item(line_item, variant, quantity, shipment)
      line_item.children.each do |child|
        remove_from_line_item(child, child.variant, child.quantity, shipment)
      end
    end
  end

  def determine_variant_price(option_value)
    if order.user.present? && order.group_order?
      option_value.distributor_price || option_value.variant.price_for_user(order.user)
    else
      option_value.special_price || option_value.variant.price
    end
  end

  def add_options(options,parent,currency,shipment)
    options.each do |o|
      ov = Spree::OptionValue.find(o)
      #add_to_line_item(nil,ov.variant, ov.quantity, currency, shipment, determine_variant_price(ov), parent.id)
      add_to_line_item(nil,ov.variant, (ov.quantity * parent.quantity), currency, shipment, ov.special_price || ov.variant.price, parent.id)
    end
  end

  private

  def remove_from_line_item(line_item, variant, quantity, shipment=nil)
    line_item.quantity += -quantity
    line_item.target_shipment= shipment

    if line_item.quantity == 0
      Spree::OrderInventory.new(order, line_item).verify(shipment)
      line_item.destroy
    else
      line_item.save!
    end

    line_item
  end

end
