Spree::OrdersController.class_eval do
  append_after_filter :set_line_item_parent, :only => :populate
  append_after_filter :add_children, :only => :populate
  append_after_filter :update_children, :only => :update

  private
  def set_line_item_parent
    unless params["product_options"].blank?
      @order = current_order
      params["product_options"].each do |k,v|
        next if v.blank?
        variant = Spree::OptionValue.find(v).variant
        line_item = @order.line_items.where(:variant_id => variant.id).first
        unless line_item.blank?
          parent = @order.line_items.where(:variant_id => params["variants"].keys.first).last
          line_item.parent_id = parent.id
          line_item.save
        end
      end
    end
  end

  def add_children
    unless params["product_options"].blank?
      params["product_options"].each do |k,v|
        next if v.blank?
        ov = Spree::OptionValue.find(v)
        li = current_order.add_variant(ov.variant,1,current_currency)
        li.price = ov.special_price || ov.variant.price
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
