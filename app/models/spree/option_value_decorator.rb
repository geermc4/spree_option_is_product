Spree::OptionValue.class_eval do
  belongs_to :variant

  def is_a_variant?
    variant_id.present?
  end

  def to_hash
    stock_state       = variant.try(:default_stock_state) || ""
    stock_item        = variant.try(:default_stock_item)
    available         = (stock_item.nil?) ? true : stock_item.available?
    product           = (is_a_variant?) ? variant.try(:product) : nil
    return {
      :id             => id,
      :presentation   => presentation,
      :quantity       => quantity,
      :variant_id     => variant_id,
      :state          => stock_state,
      :available      => available,
      :price          => special_price || variant.price,
      :default_option => default_option,
      :option_product => product,
    }
  end
end
