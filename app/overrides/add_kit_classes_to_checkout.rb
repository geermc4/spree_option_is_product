manifest_path = 'spree/checkout/_line_item_manifest'
order_details_path = 'spree/shared/_order_details'

Deface::Override.new(
  :virtual_path => manifest_path,
  :name => "add_kit_classes_to_checkout_manifest_table",
  :set_attributes => 'tr',
  :attributes => {:class => "<%= cycle('', 'alt') %> stock-item <%= (item.line_item.parent_id.nil?) ? 'master-item' : 'slave-item' %>"}
)
Deface::Override.new(
  :virtual_path => manifest_path,
  :name => 'add_kit_classes_to_checkout_delivery_title',
  :surround => "erb[loud]:contains('item.variant.name')",
  :text => '<h4><%= render_original %></h4>',
)

Deface::Override.new(
  :virtual_path => order_details_path,
  :name => "add_kit_classes_to_checkout_order_table",
  :set_attributes => 'tbody tr',
  :attributes => {:class => "<%= cycle('', 'alt') %> order_details_line_item_row <%= (item.parent_id.nil?) ? 'master-item' : 'slave-item' %>"}
)

