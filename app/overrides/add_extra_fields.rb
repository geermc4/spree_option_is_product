Deface::Override.new(
  :virtual_path   => "spree/admin/option_types/edit",
  :name           => "add_extra_headers",
  :insert_before  => ".actions",
  :partial        => "spree/admin/option_types/extra_headers",
  :original => 'bdef8b34fd0cba967cd73dbbc3f0d820cd7b73f6')

Deface::Override.new(
  :virtual_path   => "spree/admin/option_types/_option_value_fields",
  :name           => "add_extra_fields",
  :insert_before  => ".actions",
  :partial        => "spree/admin/option_types/extra_columns",
  :original => '6c2352b6edde87894af2a08ec13733936ef27d05')
