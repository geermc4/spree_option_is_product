class AddParentIdToLineItems < ActiveRecord::Migration
  def change
    add_column :spree_line_items, :parent_id, :int, :default => nil
  end
end
