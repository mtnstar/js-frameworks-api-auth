require 'test_helper'

class AuthenticationWorkflowTest < ActionDispatch::IntegrationTest
  test 'login, access buddies, logout' do
    # 1. get new token
    xhr :post, '/sessions/create', username: 'alice', password: 'secret'
    assert_response :success
    token = json_response['access_token']
    client_id = json_response['client_id']
    url = 'http://www.example.com/buddies'
    assert ApiKey.find_by(client_id: client_id)

    # 2. get buddies
    auth_header = authorization_header(client_id, token, url)
    xhr :get, '/buddies', {}, { 'HTTP_AUTHORIZATION': auth_header }
    assert_response :success

    # 3. logout
    url = 'http://www.example.com/sessions/destroy'
    auth_header = authorization_header(client_id, token, url)
    xhr :get, '/sessions/destroy', {}, { 'HTTP_AUTHORIZATION': auth_header }
    assert_response :success
    assert_not ApiKey.find_by(client_id: client_id)

    # 4. access to buddies should be denied after logout
    url = 'http://www.example.com/buddies'
    auth_header = authorization_header(client_id, token, url)
    xhr :get, '/buddies', {}, { 'HTTP_AUTHORIZATION': auth_header }
    assert_response :unauthorized

  end

  private
  def json_response
    JSON.parse(response.body)
  end

  def authorization_header(client_id, token, url)
    timestamp = Time.now.utc.to_i * 1000
    str = [timestamp, url, token].join(';')
    hash = Digest::SHA256.hexdigest(str)
    [client_id, timestamp, hash].join(';')
  end
end
