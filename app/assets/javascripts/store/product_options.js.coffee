class ProductKit
  base_price: 0
  constructor: () ->
    @set_base_price parseFloat($('#base_price').val(), 10)
    #listens for changes and updates order total
    $('.product_option').change (event) =>
      $('.product_options').each (index, element) =>
        @update_cart_options $(element)

    #initial option fields setup and order total calculation
    $('.product_options').each (index, element) =>
      @update_cart_options $(element)

  #Set the base price
  set_base_price: (price)->
    @base_price = price

  #Always gets the initial base price for a kit
  get_base_price: () ->
    return @base_price

  #Update the option fields on sidebar
  update_cart_options: (options) ->
    el = $('fieldset ul li label input:checked', options)
    oid = $('fieldset input[name="product_option_id"]', options).val()
    if el.length > 0
      $('#selected_option_' + oid + ' span').text el.siblings('.options-row').find('strong').text()
      $('#product_option_' + oid).val(el.val())
      $('#product_option_' + oid + '_price').val(parseFloat(el.siblings('input[name="option_' + oid + '_price"]').val(), 10))
      quantity_not_zero = parseFloat(el.siblings('input[name="option_' + oid + '_qty"]').val(), 10)
      #quantity_not_zero = quantity_not_zero === 0 ? 1 : quantity_not_zero
      if quantity_not_zero == 0
        quantity_not_zero = 1
      $('#product_option_' + oid + '_quantity').val(quantity_not_zero)
      this.update_cart_total()

  #Update Order total
  update_cart_total: () ->
    current_total = @get_base_price()
    $('.product_option_prices').each (index, element) =>
      item_multiply = parseInt($(element).siblings('.product_option_quantities').val(), 10)
      current_total += (parseFloat($(element).val(), 10) * item_multiply)
    $('#product-price span.price').text "$" + ( current_total.toFixed(2) )

jQuery ->
  $(document).ready ->
    new ProductKit()
