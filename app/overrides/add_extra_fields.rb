Deface::Override.new(
  :virtual_path   => "spree/admin/option_types/edit",
  :name           => "add_extra_headers",
  :insert_before  => ".actions",
  :partial        => "spree/admin/option_types/extra_headers")

Deface::Override.new(
  :virtual_path   => "spree/admin/option_types/_option_value_fields",
  :name           => "add_extra_fields",
  :insert_before  => ".actions",
  :partial        => "spree/admin/option_types/extra_columns")
