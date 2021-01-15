require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = ::Users::Operation::Create.call({ params: { email: 'dummy@panicboat.net', name: 'Spec' } })
  end

  test 'Index' do
    get '/users'
    assert_response :success
  end

  test 'Show' do
    get "/users/#{@user[:model].id}"
    assert_response :success
  end

  test 'Create' do
    post '/users', params: { email: 'spec1@panicboat.net', name: 'Spec1' }
    assert_response :success
  end

  test 'Update' do
    patch "/users/#{@user[:model].id}", params: { name: 'Spec9999' }
    assert_response :success
  end

  test 'Destroy' do
    delete "/users/#{@user[:model].id}"
    assert_response :success
  end
end
