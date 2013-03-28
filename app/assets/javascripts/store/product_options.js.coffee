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
    $('.product_option').change (event)->
      update_cart_options(event.currentTarget)
    update_cart_options = (options) ->
      el = $('fieldset ul li label input:checked', options)
      oid = $('fieldset input[name="product_option_id"]', options).val()
      if el.length > 0
        $('#selected_option_' + oid).text el.siblings('strong').text()
        $('#product_option_' + oid).val(el.val())
        update_cart_total(parseFloat(el.siblings('input[type="hidden"]').val(), 10))
    update_cart_total = (add) ->
      current_total = Math.round(parseFloat($('#product-price span.price').text().replace(/\$/, ""), 10))
      $('#product-price span.price').text "$" + (current_total + add )
    $('.product_option').each(->
        update_cart_options $(this)
    )
