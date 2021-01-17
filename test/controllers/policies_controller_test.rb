require 'test_helper'

class PoliciesControllerTest < ActionDispatch::IntegrationTest
  fixtures :policies, :users

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
      get '/policies'
    end
    assert_response :success
  end

  test 'Show' do
    ::ApplicationController.stub_any_instance(:_options, @options) do
      get "/policies/#{policies(:spec).id}"
    end
    assert_response :success
  end

  test 'Create' do
    ::ApplicationController.stub_any_instance(:_options, @options) do
      post '/policies', params: { name: 'spec', description: 'desc' }
    end
    assert_response :success
  end

  test 'Update' do
    ::ApplicationController.stub_any_instance(:_options, @options) do
      patch "/policies/#{policies(:spec).id}", params: { name: 'spec' }
    end
    assert_response :success
  end

  test 'Destroy' do
    ::ApplicationController.stub_any_instance(:_options, @options) do
      delete "/policies/#{policies(:spec).id}"
    end
    assert_response :success
  end
end
