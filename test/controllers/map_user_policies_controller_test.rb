require 'test_helper'

class MapUserPoliciesControllerTest < ActionDispatch::IntegrationTest
  fixtures :users, :policies, :map_user_policies

  def setup
    WebMock.stub_request(:get, %r{#{ENV['HTTP_IAM_URL']}/permissions/}).to_return(
      body: File.read("#{Rails.root}/test/fixtures/files/platform_iam_get_permission.json"),
      status: 200,
      headers: { 'Content-Type': 'application/json' }
    )
  end

  test 'Index' do
    ::ApplicationController.stub_any_instance(:_session, users(:standalone)) do
      get "/users/#{users(:spec).id}/policies"
    end
    assert_response :success
  end

  test 'Create' do
    ::ApplicationController.stub_any_instance(:_session, users(:standalone)) do
      post "/users/#{users(:spec).id}/policies", params: { policy_id: policies(:spec).id }
    end
    assert_response :success
  end

  test 'Destroy' do
    ::ApplicationController.stub_any_instance(:_session, users(:standalone)) do
      delete "/users/#{map_user_policies(:spec).user_id}/policies/#{map_user_policies(:spec).policy_id}"
    end
    assert_response :success
  end
end
