Deface::Override.new(
  :virtual_path  => "spree/admin/option_types/edit",
  :name          => "add_variant_select",
  :insert_after  => %q(code[erb-loud]:contains("render :partial => 'form'")),
  :partial       => "spree/admin/option_types/product_based_option",
)

