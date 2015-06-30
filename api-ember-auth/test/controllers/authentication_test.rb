require 'test_helper'

class AuthenticationTest < ActiveSupport::TestCase

  TEN_MINUTES = 6000000

  include Authentication
  setup do
    @request_headers = {}
    @url = 'http://localhost/buddies'

    @request = mock()
    @request.stubs(:headers).returns(@request_headers)
    @request.stubs(:url).returns(@url)

    @user = User.find_by(username: 'alice')
    @api_key = ApiKey.create({user: @user})
    @timestamp = Time.now.utc.to_i

    @client_id = @api_key.client_id
    @access_token = @api_key.access_token
    hash = Digest::SHA256.hexdigest([@timestamp, @url, @access_token].join(';')) 
    @request_headers["Authorization"] = [@client_id, @timestamp, hash].join(';')
  end

  test 'authentication ok if timestamp, url and token result in correct hash value' do
    assert authenticated?
  end

  test 'authentication nok if authorization header missing' do
    @request_headers["Authorization"] = nil
    assert_not authenticated?
  end

  test 'authentication nok if api key doesnt exist' do
    @api_key.destroy!
    assert_not authenticated?
  end

  test 'authentication nok if timestamp too old' do
    @timestamp = @timestamp - TEN_MINUTES
    hash = Digest::SHA256.hexdigest([@timestamp, @url, @access_token].join(';')) 
    @request_headers["Authorization"] = [@client_id, @timestamp, hash].join(';')
    assert_not authenticated?
  end

  test 'authentication nok if timestamp too new' do
    @timestamp = @timestamp + TEN_MINUTES
    hash = Digest::SHA256.hexdigest([@timestamp, @url, @access_token].join(';')) 
    @request_headers["Authorization"] = [@client_id, @timestamp, hash].join(';')
    assert_not authenticated?
  end

  test '#timestamp_ok? false if timestamp too old' do
    timestamp = Time.now.utc.to_i - TEN_MINUTES
    assert_not timestamp_ok?(timestamp)
  end

  test '#timestamp_ok? false if timestamp too new' do
    timestamp = Time.now.utc.to_i + TEN_MINUTES
    assert_not timestamp_ok?(timestamp)
  end

  private
  def request
    @request
  end

end
