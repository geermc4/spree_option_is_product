Deface::Override.new(
  :virtual_path       =>  "spree/admin/option_types/_form",
  :name               =>  "add_product_based_checkbox_classes_remove_alpha",
  :remove_from_attributes  =>  "[data-hook='admin_option_type_form_fields'] div.columns",
  :attributes         =>  {:class => 'eight'})
Deface::Override.new(
  :virtual_path       =>  "spree/admin/option_types/_form",
  :name               =>  "add_product_based_checkbox_classes",
  :add_to_attributes  =>  "[data-hook='admin_option_type_form_fields'] div.columns",
  :attributes         =>  {:class => 'six'})
Deface::Override.new(
  :virtual_path  => "spree/admin/option_types/_form",
  :name          => "add_product_extra_checkboxes",
  :insert_bottom => "[data-hook='admin_option_type_form_fields'],#admin_option_type_form_fields[data-hook]",
  :partial       => "spree/admin/option_types/extra_checkboxes")
