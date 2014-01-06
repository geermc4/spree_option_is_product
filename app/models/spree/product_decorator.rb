Spree::Product.class_eval do
  def has_product_options?
    return false if option_types.blank?
    option_types.collect(&:product_based).include?(true)
  end

  def product_options
    return nil unless has_product_options?

    option_types.map do |o|
      {
        :id       => o.id,
        :display  => o.presentation,
        :optional => o.optional?,
        :options  => o.option_values.collect(&:to_hash)
      }
    end
  end

  def master_price(*some_price)
    new_price = ( !some_price.empty? ) ? some_price.try(:first) : self.price
    if !self.product_options.nil?
      options_price = self.product_options.select{ |po| po[:optional] == false }.map{ |opt, sum| opt[:options].first[:price] }.inject(:+)
      if !options_price.nil?
        optional_values_default_pricing = self.product_options.select{ |po| po[:optional] == true }.collect{ |opt| opt[:options] }.collect{ |op| op.select{ |pop| pop[:default_option] == true }.first }.select{ |s| !s.nil? }.select{ |s| !s.empty? }.map{ |v| v[:price] }.inject(:+).to_f
        new_price += (options_price + (optional_values_default_pricing.nil? ? 0 : optional_values_default_pricing))
      end
    end
    Spree::Money.new(new_price || 0, {:currency => self.currency} )
  end
  def master_client_price
    self.master_price(Spree::Price.where(:variant_id => self.master.id).try(:first).amount)
  end

end
