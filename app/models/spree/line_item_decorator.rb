Spree::LineItem.class_eval do
  belongs_to :parent, :class_name => "Spree::LineItem", :foreign_key => :parent_id
  has_many :children, :class_name => "Spree::LineItem", :foreign_key => :parent_id, :dependent => :destroy
  has_many :inventory_units, inverse_of: :line_item

  def child_items
    self.order.line_items.select { |l| l.parent_id == self.id }
  end

  #From spree 2.2 to match new OrderInventory params
  private
  def update_inventory
    if changed?
      Spree::OrderInventory.new(self.order, self).verify(target_shipment)
    end
  end
end
