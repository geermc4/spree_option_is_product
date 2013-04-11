fields=['quantity','special_price']

fields.each do |f|
  Deface::Override.new(
    :virtual_path   => "spree/admin/option_types/edit",
    :name           => "add_#{f}_header",
    :insert_before  => ".actions",
    :text           => "<th><%= t(:#{f}) %></th>")

  Deface::Override.new(
    :virtual_path   => "spree/admin/option_types/_option_value_fields",
    :name           => "add_#{f}_field",
    :insert_before  => ".actions",
    :text           => "<td><%= f.text_field :#{f} %> </td>")
end
