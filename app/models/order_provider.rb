class OrderProvider < ActiveRecord::Base
  validates_numericality_of :order_id, :provider_id,  :only_integer => true, :greater_than => 0, :allow_nil => true

  belongs_to :order
  belongs_to :provider

 validates_associated :order, :provider, :on => :update

  class << self
    def valid_options
      { :order_id=> 1,  :provider_id=> 12}
    end

    def build_valid
      OrderProvider.new(OrderProvider.valid_options)
    end
  end

#  def validate
#    if (order == nil && order_id == nil)
#      errors.add_to_base("You should use a order object or order_id")
 #   end
 #   if (provider == nil && provider_id == nil)
 #     errors.add_to_base("You should use a provider object or provider_id")
 #   end
 # end
end
