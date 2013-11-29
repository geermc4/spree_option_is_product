Deface::Override.new(
  :virtual_path => "spree/orders/_line_item",
  :name         => "remove_remove_button",
  :surround     => "erb[loud]:contains('icons/delete.png')",
  :text         => "<% unless line_item.parent_id %> <%= render_original %> <% end %>")

Deface::Override.new(
  :virtual_path => "spree/orders/_line_item",
  :name         => "remove_qty_field",
  :surround     => "erb[loud]:contains('item_form.number_field :quantity')",
  :text         => "<% if line_item.parent_id %> <%=line_item.quantity%> <% else %> <%= render_original %> <% end %>")
