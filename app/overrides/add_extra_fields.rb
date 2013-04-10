Deface::Override.new(
  :virtual_path   => "spree/admin/option_types/edit",
  :name           => "special_price_header",
  :insert_before  => ".actions",
  :text           => "<th><%= t(:special_price) %></th>")

Deface::Override.new(
  :virtual_path   => "spree/admin/option_types/_option_value_fields",
  :name           => "add_price_field",
  :insert_before  => ".actions",
  :text           => "<td><%= f.text_field :special_price %> </td>")
