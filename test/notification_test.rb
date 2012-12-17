#encoding: utf-8
require 'test_helper'
require 'openssl'
require 'net/http'

class NotificationTest < ActiveSupport::TestCase

  Themockerpush::SECRET_KEY = '00000000000000000'
  Themockerpush::API_KEY = '12345'
  
  setup do
    @digest = OpenSSL::Digest::Digest.new('sha1')
  end
  
  test "create a notification with valid hmac auth" do
    notification = Themockerpush::Notification.new(
              :message => "Hello world", 
              :badge => "12", 
              :tokens => ['t1', 't2'],
              :scheduled_at_date => '2012-12-31',
              :scheduled_at_time => '20:35')
    hmac_token = OpenSSL::HMAC.hexdigest @digest, Themockerpush::SECRET_KEY, notification.to_json
    ActiveResource::HttpMock.respond_to do |mock|
      mock.post "/api/#{Themockerpush::API_KEY}/notifications?hmac_token=#{hmac_token}", {}, '', 201
    end
    assert notification.push
  end
  
end