class AddOptionPrice < ActiveRecord::Migration
  def change
    add_column :spree_option_values, :special_price, :decimal, :precision => 8, :scale => 2
  end
end
