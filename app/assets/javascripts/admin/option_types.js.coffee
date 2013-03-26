jQuery ->
  $(document).ready ->
    if $('#option_type_product_based').is(':checked')
      $('#new_add_option_value').appendTo("#add_variant")
