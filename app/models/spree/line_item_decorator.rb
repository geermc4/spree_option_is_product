Spree::LineItem.class_eval do
  attr_accessible :parent_id
  belongs_to :parent, :class_name => "Spree::LineItem", :foreign_key => :parent_id
  has_many :children, :class_name => "Spree::LineItem", :foreign_key => :parent_id, :dependent => :destroy
end
