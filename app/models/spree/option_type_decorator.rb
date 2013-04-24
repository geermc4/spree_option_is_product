Spree::OptionType.class_eval do
  attr_accessible :product_based, :optional
  scope :product_based, where(:product_based => true)
end
