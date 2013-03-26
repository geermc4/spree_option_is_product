class AddProductBasedToOptionType < ActiveRecord::Migration
  def change
    add_column :spree_option_types, :product_based, :boolean
  end
end
