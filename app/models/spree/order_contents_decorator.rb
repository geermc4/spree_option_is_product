Spree::OrderContents.class_eval do

  def add(variant, quantity, currency=nil, shipment=nil, force_new_line_item=false)
    line_item = force_new_line_item ? nil : order.find_line_item_by_variant(variant)
    add_to_line_item(line_item, variant, quantity, currency, shipment)
  end

end