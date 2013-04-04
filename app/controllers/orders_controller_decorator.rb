Spree::OrdersController.class_eval do
  before_filter :grab_options, :only => :populate
  append_after_filter :set_line_item_parent, :only => :populate
  append_after_filter :update_children, :only => :update

  private
  def grab_options
    unless params["product_options"].blank?
      params["product_options"].each do |k,v|
        next if v.blank?
        params["variants"].merge!({v => "1"})
      end
    end
  end

  def set_line_item_parent
    unless params["product_options"].blank?
      @order = current_order
      params["product_options"].each do |k,v|
        next if v.blank?
        line_item = @order.line_items.where(:variant_id => v).first
        unless line_item.blank?
          parent = @order.line_items.where(:variant_id => params["variants"].keys.first).last
          line_item.parent_id = parent.id
          line_item.save
        end
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
