class AddQuantityToOptionValue < ActiveRecord::Migration
  def change
    add_column :spree_option_values, :quantity, :integer, :default => 1
  end
end
