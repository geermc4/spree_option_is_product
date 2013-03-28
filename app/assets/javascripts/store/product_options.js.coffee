jQuery ->
  $(document).ready ->
    $('.product_option').change ->
      txt = $(this).children(':selected').text()
      $('#selected_' + $(this).attr('id')).text(txt)
      $('#product_' + $(this).attr('id')).val($(this).val())
