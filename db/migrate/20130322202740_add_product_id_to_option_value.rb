class AddProductIdToOptionValue < ActiveRecord::Migration
  def change
    add_column :spree_option_values, :variant_id, :int
  end
end
