class AddOptionalToOptionType < ActiveRecord::Migration
  def change
    add_column :spree_option_types, :optional, :boolean
  end
end
