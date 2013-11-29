new_variant_display = %(
    <% if @product.option_types.collect(&:product_based).include?(true) %>
      <%= render :partial => 'spree/products/selected_options_display'%>
    <% elsif @product.variants_and_option_values(current_currency).any? %>
)

Deface::Override.new(
  :virtual_path   => "spree/products/_cart_form",
  :name           => "change_variant_display",
  :replace        => "erb[silent]:contains('if @product.variants_and_option_values(current_currency).any?')",
  :text           => new_variant_display,
  :original       => 'da5b4e18e3090d127619485fd6d49e3d02b32a6c')
