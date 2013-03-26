Deface::Override.new(
  :virtual_path  => "spree/admin/option_types/edit",
  :name          => "add_variant_select",
#  :insert_before => "code[erb-loud]:contains('f.text_field :name')",
  :insert_after => %q(code[erb-loud]:contains("render :partial => 'form'")),
  :partial       => "spree/admin/option_types/product_based_option",
)

