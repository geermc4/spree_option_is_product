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
          :id           => v.variant.id,
          :presentation => v.presentation,
          :price        => v.variant.price,
        }
      end
      options << { :id => o.id, :display => o.presentation, :options => values }
    end
    options
  end
end
