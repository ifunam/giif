require File.dirname(__FILE__) + '/../test_helper'

class OrderProviderTest < ActiveSupport::TestCase
  fixtures :orders, :providers, :order_providers

  should_require_attributes :order_id, :provider_id
  should_belong_to :order, :provider
end
