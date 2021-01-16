require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  fixtures :users

  def setup
    WebMock.stub_request(:get, %r{#{ENV['HTTP_IAM_URL']}/permissions/}).to_return(
      body: File.read("#{Rails.root}/test/fixtures/files/platform_iam_get_permission.json"),
      status: 200,
      headers: { 'Content-Type': 'application/json' }
    )
  end

  test 'Index' do
    ::ApplicationController.stub_any_instance(:_session, users(:standalone)) do
      get '/users'
    end
    assert_response :success
  end

  test 'Show' do
    ::ApplicationController.stub_any_instance(:_session, users(:standalone)) do
      get "/users/#{users(:spec).id}"
    end
    assert_response :success
  end

  test 'Create' do
    ::ApplicationController.stub_any_instance(:_session, users(:standalone)) do
      post '/users', params: { email: 'spec1@panicboat.net', name: 'Spec1' }
    end
    assert_response :success
  end

  test 'Update' do
    ::ApplicationController.stub_any_instance(:_session, users(:standalone)) do
      patch "/users/#{users(:spec).id}", params: { name: 'Spec9999' }
    end
    assert_response :success
  end

  test 'Destroy' do
    ::ApplicationController.stub_any_instance(:_session, users(:standalone)) do
      delete "/users/#{users(:spec).id}"
    end
    assert_response :success
  end
end
