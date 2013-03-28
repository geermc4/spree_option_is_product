Deface::Override.new(
  :virtual_path => "spree/products/show",
  :name         => "add_option_select_to_products",
  :insert_after => "[data-hook='product_right_part_wrap'] #product-description",
  :partial      => "spree/products/options_display"
)
