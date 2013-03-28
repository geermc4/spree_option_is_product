Spree::OrdersController.class_eval do
  before_filter :grab_options, :only => :populate

  private
  def grab_options
    unless params["product_options"].blank?
      options = params["product_options"]
      params.reject! { |k| k == "product_options" }
      options.each do |k,v|
        next if v.blank?
        params["variants"].merge!({v => "1"})
      end
    end
  end
end
