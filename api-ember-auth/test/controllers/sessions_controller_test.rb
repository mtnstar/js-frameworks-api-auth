require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  setup do
    @user = User.find_by(username: 'alice')
  end

  test 'return 401 and error if invalid user/pw' do
    post :create, username: @user.username, password: 'wrong'
    assert_response :unauthorized
    json = JSON.parse(response.body)
    assert json.include?('errors')
    assert_match /invalid user or password/, json['errors'].first
  end

  test 'returns new authentication token and client id' do
    post :create, username: @user.username, password: 'secret'
    assert_response :success
    json = JSON.parse(response.body)
    assert json.include?('access_token')
    assert json.include?('client_id')
    assert_not json.include?('user_id')
    assert_not json.include?('id')
  end

end
