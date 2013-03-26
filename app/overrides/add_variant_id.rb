Deface::Override.new(
  :virtual_path  => "spree/admin/option_types/_option_value_fields",
  :name          => "add_variant_id",
  :insert_bottom => "[data-hook='option_value'],#option_value[data-hook]",
  :text          => "<%= f.hidden_field :variant_id %>"
)
