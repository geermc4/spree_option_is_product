new_variant_display = %(
  <% if @product.option_types.collect(&:product_based).include?(true) %>
    <%= render :partial => 'spree/products/selected_options_display'%>
  <% else %>
    <%= render_original %>
  <% end %>
)

Deface::Override.new(
  :virtual_path   => "spree/products/_cart_form",
  :name           => "change_variant_display",
  :surround       => "code[erb-silent]:contains('if @product.has_variants?')",
  :text           => new_variant_display,
  :original       => 'da5b4e18e3090d127619485fd6d49e3d02b32a6c')
