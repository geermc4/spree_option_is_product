Spree::OptionValue.class_eval do
  belongs_to :variant
  attr_accessible :variant_id

  def is_a_variant?
    !variant_id.blank?
  end
end
