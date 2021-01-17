require 'test_helper'

class MapRolePoliciesControllerTest < ActionDispatch::IntegrationTest
  fixtures :roles, :policies, :map_role_policies, :users

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
      get "/roles/#{roles(:spec).id}/policies"
    end
    assert_response :success
  end

  test 'Create' do
    ::ApplicationController.stub_any_instance(:_options, @options) do
      post "/roles/#{roles(:spec).id}/policies", params: { policy_id: policies(:spec).id }
    end
    assert_response :success
  end

  test 'Destroy' do
    ::ApplicationController.stub_any_instance(:_options, @options) do
      delete "/roles/#{map_role_policies(:spec).role_id}/policies/#{map_role_policies(:spec).policy_id}"
    end
    assert_response :success
  end
end
