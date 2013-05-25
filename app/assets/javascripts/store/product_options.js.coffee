jQuery ->
  $(document).ready ->
    read_more = (where)->
      $(where).addClass 'read-more-toggle'
      $('<div></div>').attr('id', 'read-more-mask').addClass('collapsed').append('<a href="#">READ MORE</a>').click((event)->
        event.preventDefault()
        $(where).removeClass 'read-more-toggle'
      ).appendTo where
    if $('.product-description[data-hook="description"]').height() > 250
      read_more $('.product-description[data-hook="description"]')
    trigger_original_price_hide = () ->
      if $('#original-price').length > 0
        $('#original-price').hide()
    $('.product_option').change (event)->
      $('#original-price').hide()
      update_cart_options(event.currentTarget)
    update_cart_options = (options) ->
      el = $('fieldset ul li label input:checked', options)
      oid = $('fieldset input[name="product_option_id"]', options).val()
      if el.length > 0
        $('#selected_option_' + oid + ' span').text el.siblings('strong').text()
        $('#product_option_' + oid).val(el.val())
        $('#product_option_' + oid + '_price').val(parseFloat(el.siblings('input[name="option_' + oid + '_price"]').val(), 10))
        $('#product_option_' + oid + '_quantity').val(parseFloat(el.siblings('input[name="option_' + oid + '_qty"]').val(), 10))
        update_cart_total()
    get_base_price = () ->
      return parseFloat($('#base_price').val(), 10)
    update_cart_total = () ->
      current_total = get_base_price()
      $('.product_option_prices').each(->
        item_multiply = parseInt($(this).siblings('.product_option_quantities').val(), 10)
        current_total += (parseFloat($(this).val(), 10) * ( ( item_multiply > 0 ) ? item_multiply : 1 ))
      )
      $('#product-price span.price').text "$" + ( current_total.toFixed(2) )
    $('.product_option').each(->
      update_cart_options $(this)
    )
