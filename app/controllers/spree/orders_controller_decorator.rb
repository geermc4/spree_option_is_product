Spree::OrdersController.class_eval do
  append_after_filter :add_children, :only => :populate
  append_after_filter :update_children, :only => :update

  private

  def add_children
    unless params["product_options"].blank?
      unless params["variants"].blank?
        parent = current_order.find_line_item_by_variant(Spree::Variant.find(params["variants"].first[0]))
        params["product_options"].each do |k,v|
          next if v.blank?
          ov = Spree::OptionValue.find(v)
          if !!spree_current_user && !!spree_current_user.user_group && !! spree_current_user.user_group.name.match(/^Distributor.*/)
            price = ov.distributor_price
          else
            price = ov.special_price
          end
          # Spree increments the quantity of existing line items when
          # populating the order if adding the same product.
          # Here we force the creation of new LineItems so we don't
          # merge product's options with existing items in the order.
          li = current_order.contents.add(ov.variant,(ov.quantity * parent.quantity),current_currency, nil, (price || ov.variant.price), true)
          li.parent_id = parent.id
          li.save!
        end
      end
    end
  end

  def update_children
    unless current_order.blank? || current_order.line_items.blank?
      current_order.line_items.where("parent_id is not null").each do |l|
        quantity = nil
        l.parent.variant.product.product_options.each { |i| i[:options].each { |o| quantity = o[:quantity] if o[:variant_id] == l.variant_id } }
        l.quantity = l.parent.quantity * (quantity || 1)
        l.save
      end
    end
  end
end
