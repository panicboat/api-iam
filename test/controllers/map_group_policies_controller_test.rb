require 'test_helper'

class MapGroupPoliciesControllerTest < ActionDispatch::IntegrationTest
  fixtures :groups, :policies, :map_group_policies, :users

  def setup
    WebMock.stub_request(:get, "#{ENV['HTTP_IAM_URL']}/permissions/00000000-0000-0000-0000-000000000000").to_return(
      body: File.read("#{Rails.root}/test/fixtures/files/platform_iam_get_permission.json"),
      status: 200,
      headers: { 'Content-Type': 'application/json' }
    )
  end

  test 'Index' do
    ::ApplicationController.stub_any_instance(:_session, users(:standalone)) do
      get "/groups/#{groups(:spec).id}/policies"
    end
    assert_response :success
  end

  test 'Create' do
    ::ApplicationController.stub_any_instance(:_session, users(:standalone)) do
      post "/groups/#{groups(:spec).id}/policies", params: { policy_id: policies(:spec).id }
    end
    assert_response :success
  end

  test 'Destroy' do
    ::ApplicationController.stub_any_instance(:_session, users(:standalone)) do
      delete "/groups/#{map_group_policies(:spec).group_id}/policies/#{map_group_policies(:spec).policy_id}"
    end
    assert_response :success
  end
end
