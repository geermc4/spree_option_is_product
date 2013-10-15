Spree::OptionType.class_eval do
  scope :product_based, -> { where :product_based => true }
end
