require 'test_helper'

class ServicesControllerTest < ActionDispatch::IntegrationTest
  fixtures :services, :users

  def setup
    @options = { action: '00000000-0000-0000-0000-000000000000', current_user: users(:standalone) }
    WebMock.stub_request(:get, %r{#{ENV['HTTP_IAM_URL']}/permissions/}).to_return(
      body: File.read("#{Rails.root}/test/fixtures/files/platform_iam_get_permission.json"),
      status: 200,
      headers: { 'Content-Type': 'application/json' }
    )
  end

  test 'Index' do
    ::ApplicationController.stub_any_instance(:_options, @options) do
      get '/services'
    end
    assert_response :success
  end

  test 'Show' do
    ::ApplicationController.stub_any_instance(:_options, @options) do
      get "/services/#{services(:spec).id}"
    end
    assert_response :success
  end

  test 'Create' do
    ::ApplicationController.stub_any_instance(:_options, @options) do
      post '/services', params: { name: 'service', description: 'desc' }
    end
    assert_response :success
  end

  test 'Update' do
    ::ApplicationController.stub_any_instance(:_options, @options) do
      patch "/services/#{services(:spec).id}", params: { name: 'service' }
    end
    assert_response :success
  end

  test 'Destroy' do
    ::ApplicationController.stub_any_instance(:_options, @options) do
      delete "/services/#{services(:spec).id}"
    end
    assert_response :success
  end
end
