jQuery ->
  $(document).ready ->
    if $('#option_type_product_based').is(':checked')
      $('#new_add_option_value').appendTo("#add_variant")

      $('#add_variant').click ->
        if $('#add_variant_id').val() == ''
          $('#option_values tr:first').remove()
          alert('Select variant')
          return false

        #WET
        $('#option_values tr:first td[class="name"] input').val($('#s2id_add_variant_id span').text())
        $('#option_values tr:first td[class="presentation"] input').val($('#s2id_add_variant_id span').text())

        obj = $('#option_values tr:first td[class="name"] input')
        hiddenInput = $('<input/>',{
          type:  'hidden',
          id:    obj.attr("id").replace("name","variant_id"),
          name:  obj.attr("name").replace("name","variant_id")
          value: $('#add_variant_id').val(),
        })
        hiddenInput.appendTo('#option_values tr:first')
