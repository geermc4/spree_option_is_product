Spree::OptionValue.class_eval do
  belongs_to :variant

  def is_a_variant?
    !variant_id.blank?
  end
end
