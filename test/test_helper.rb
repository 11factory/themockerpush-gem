ENV["RAILS_ENV"] = "test"
require 'themockerpush'
require 'test/unit'
require 'fakeweb'
require 'active_support'
require 'active_resource/http_mock'

class ActiveSupport::TestCase
  FakeWeb.allow_net_connect = false
end