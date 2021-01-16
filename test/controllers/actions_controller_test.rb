require 'test_helper'

class ActionsControllerTest < ActionDispatch::IntegrationTest
  fixtures :actions, :users

  def setup
    WebMock.stub_request(:get, %r{#{ENV['HTTP_IAM_URL']}/permissions/}).to_return(
      body: File.read("#{Rails.root}/test/fixtures/files/platform_iam_get_permission.json"),
      status: 200,
      headers: { 'Content-Type': 'application/json' }
    )
  end

  test 'Index' do
    ::ApplicationController.stub_any_instance(:_session, users(:standalone)) do
      get "/services/#{actions(:read).service_id}/actions"
    end
    assert_response :success
  end

  test 'Show' do
    ::ApplicationController.stub_any_instance(:_session, users(:standalone)) do
      get "/services/#{actions(:read).service_id}/actions/#{actions(:read).id}"
    end
    assert_response :success
  end

  test 'Create' do
    ::ApplicationController.stub_any_instance(:_session, users(:standalone)) do
      post "/services/#{actions(:read).service_id}/actions", params: { name: 'spec', description: 'desc', access_level: 'list' }
    end
    assert_response :success
  end

  test 'Update' do
    ::ApplicationController.stub_any_instance(:_session, users(:standalone)) do
      patch "/services/#{actions(:read).service_id}/actions/#{actions(:read).id}", params: { name: 'spec' }
    end
    assert_response :success
  end

  test 'Destroy' do
    ::ApplicationController.stub_any_instance(:_session, users(:standalone)) do
      delete "/services/#{actions(:read).service_id}/actions/#{actions(:read).id}"
    end
    assert_response :success
  end
end
