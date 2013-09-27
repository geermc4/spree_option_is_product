Spree::Variant.class_eval do
  def default_stock_state
    stock_item_state_for_stock_location(default_stock_location_from_shipping_category)
  end

  def default_stock_item
    default_stock_location_from_shipping_category.stock_item(self)
  end

  private

  def stock_item_state_for_stock_location(stock_location)
    stock_item = stock_location.stock_item(self)
    if stock_item.in_stock?
      stock_state = ""
    elsif stock_item.backorderable?
      stock_state = Spree.t(:product_option_backorder)
    else
      stock_state = Spree.t(:product_option_not_available)
    end
    return stock_state
  end

  def default_stock_location_from_shipping_category
    stock_location_id = 1
    if shipping_category_id == 1
      stock_location_id = 2
    end
    return Spree::StockLocation.find(stock_location_id)
  end
end
