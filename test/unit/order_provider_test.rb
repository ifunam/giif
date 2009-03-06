require File.dirname(__FILE__) + '/../test_helper'

class OrderProviderTest < ActiveSupport::TestCase
  fixtures :orders, :providers, :order_providers

  should_validate_presence_of :order_id, :provider_id
  should_belong_to :order, :provider
end
