require 'test_helper'

module MapUserPolicies
  class DestroyTest < ActionDispatch::IntegrationTest
    fixtures :map_user_policies, :users, :policies

    setup do
      @current_user = JSON.parse({ name: 'Spec' }.to_json, object_class: OpenStruct)
      WebMock.stub_request(:get, %r{#{ENV['HTTP_IAM_URL']}/permissions/}).to_return(
        body: File.read("#{Rails.root}/test/fixtures/files/platform_iam_get_permission.json"),
        status: 200,
        headers: { 'Content-Type': 'application/json' }
      )
    end

    def default_params
      { user_id: users(:spec).id, policy_id: policies(:spec).id }
    end

    def expected_attrs
      { user_id: users(:spec).id, policy_id: policies(:spec).id }
    end

    test 'Permission Deny' do
      e = assert_raises InvalidPermissions do
        Operation::Destroy.call(params: { user_id: map_user_policies(:spec).user_id, policy_id: map_user_policies(:spec).policy_id })
      end
      assert_equal ['Permissions is invalid'], JSON.parse(e.message)
    end

    test 'Destory Data' do
      ctx = Operation::Destroy.call(params: { user_id: map_user_policies(:spec).user_id, policy_id: map_user_policies(:spec).policy_id }, current_user: @current_user, action: 'DUMMY_ACTION_ID')
      assert ctx.success?
      assert_equal [], ::MapUserPolicy.where({ user_id: map_user_policies(:spec).user_id })
    end

    test 'Destroy No Data' do
      e = assert_raises InvalidParameters do
        Operation::Destroy.call(params: { user_id: -1, policy_id: -1 }, current_user: @current_user, action: 'DUMMY_ACTION_ID')
      end
      assert_equal ['User is invalid', 'Policy is invalid'], JSON.parse(e.message)
    end
  end
end
