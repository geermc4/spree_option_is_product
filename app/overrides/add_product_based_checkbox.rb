Deface::Override.new(
  :virtual_path  => "spree/admin/option_types/_form",
  :name          => "add_product_based_checkbox",
  :insert_bottom => "[data-hook='admin_option_type_form_fields'],#admin_option_type_form_fields[data-hook]",
  :partial       => "spree/admin/option_types/product_based_checkbox")
