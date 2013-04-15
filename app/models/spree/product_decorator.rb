Spree::Product.class_eval do
  def has_product_options?
    return false if option_types.blank?
    option_types.collect(&:product_based).include?(true)
  end

  def product_options
    return nil unless has_product_options?

    options = []
    option_types.each do |o|
      values = []
      o.option_values.each do |v|
        values << {
          :id           => v.id,
          :presentation => v.presentation,
          :quantity     => v.quantity,
          :variant_id   => v.variant_id,
          :price        => v.special_price || v.variant.price,
        }
      end
      options << {
        :id       => o.id,
        :display  => o.presentation,
        :optional => o.optional?,
        :options  => values }
    end
    options
  end

  def master_price
    new_price = self.price
    if !self.product_options.nil?
      new_price += self.product_options.select{ |po| po[:optional] == false }.map{ |opt, sum| opt[:options].first[:price] }.inject(:+)
    end
    Spree::Money.new(new_price || 0, {:currency => self.currency} )
  end

end
