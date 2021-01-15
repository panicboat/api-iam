require 'test_helper'

module MapRolePolicies
  class DestroyTest < ActionDispatch::IntegrationTest
    fixtures :map_role_policies, :roles, :policies

    setup do
      @current_user = JSON.parse({ name: 'Spec' }.to_json, object_class: OpenStruct)
      WebMock.stub_request(:get, "#{ENV['HTTP_IAM_URL']}/permissions/00000000-0000-0000-0000-000000000000").to_return(
        body: File.read("#{Rails.root}/test/fixtures/files/platform_iam_get_permission.json"),
        status: 200,
        headers: { 'Content-Type': 'application/json' }
      )
    end

    def default_params
      { role_id: roles(:spec).id, policy_id: policies(:spec).id }
    end

    def expected_attrs
      { role_id: roles(:spec).id, policy_id: policies(:spec).id }
    end

    test 'Permission Deny' do
      e = assert_raises InvalidPermissions do
        Operation::Destroy.call(params: { role_id: map_role_policies(:spec).role_id, policy_id: map_role_policies(:spec).policy_id })
      end
      assert_equal ['Permissions is invalid'], JSON.parse(e.message)
    end

    test 'Destory Data' do
      ctx = Operation::Destroy.call(params: { role_id: map_role_policies(:spec).role_id, policy_id: map_role_policies(:spec).policy_id }, current_user: @current_user)
      assert ctx.success?
      assert_equal [], ::MapRolePolicy.where({ role_id: map_role_policies(:spec).role_id })
    end

    test 'Destroy No Data' do
      e = assert_raises InvalidParameters do
        Operation::Destroy.call(params: { role_id: -1, policy_id: -1 }, current_user: @current_user)
      end
      assert_equal ['Role is invalid', 'Policy is invalid'], JSON.parse(e.message)
    end
  end
end
