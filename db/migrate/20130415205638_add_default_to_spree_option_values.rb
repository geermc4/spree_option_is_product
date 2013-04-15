class AddDefaultToSpreeOptionValues < ActiveRecord::Migration
  def change
    add_column :spree_option_values, :default, :boolean
  end
end
