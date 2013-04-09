Spree::OrdersController.class_eval do
  append_after_filter :add_children, :only => :populate
  append_after_filter :update_children, :only => :update

  private

  def add_children
    unless params["product_options"].blank?
      parent = current_order.find_line_item_by_variant(Spree::Variant.find(params["variants"].first[0]))

      params["product_options"].each do |k,v|
        next if v.blank?
        ov = Spree::OptionValue.find(v)
        li = current_order.add_variant(ov.variant,1,current_currency)
        li.price = ov.special_price || ov.variant.price
        li.parent_id = parent.id
        li.save!
      end
    end
  end

  def update_children
    unless current_order.blank? || current_order.line_items.blank?
      current_order.line_items.where("parent_id is not null").each do |l|
        l.quantity = l.parent.quantity
        l.save
      end
    end
  end
end
