Deface::Override.new(
  :virtual_path => "spree/products/show",
  :name         => "add_option_select_to_products",
  :insert_bottom => "[data-hook='product_show'],#cart_form[product_show]",
  :partial      => "spree/products/options_display"
)
