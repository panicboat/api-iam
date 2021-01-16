require 'test_helper'

module MapGroupRoles
  class DestroyTest < ActionDispatch::IntegrationTest
    fixtures :map_group_roles, :groups, :roles

    setup do
      @current_user = JSON.parse({ name: 'Spec' }.to_json, object_class: OpenStruct)
      WebMock.stub_request(:get, %r{#{ENV['HTTP_IAM_URL']}/permissions/}).to_return(
        body: File.read("#{Rails.root}/test/fixtures/files/platform_iam_get_permission.json"),
        status: 200,
        headers: { 'Content-Type': 'application/json' }
      )
    end

    def default_params
      { group_id: groups(:spec).id, role_id: roles(:spec).id }
    end

    def expected_attrs
      { group_id: groups(:spec).id, role_id: roles(:spec).id }
    end

    test 'Permission Deny' do
      e = assert_raises InvalidPermissions do
        Operation::Destroy.call(params: { group_id: map_group_roles(:spec).group_id, role_id: map_group_roles(:spec).role_id })
      end
      assert_equal ['Permissions is invalid'], JSON.parse(e.message)
    end

    test 'Destory Data' do
      ctx = Operation::Destroy.call(params: { group_id: map_group_roles(:spec).group_id, role_id: map_group_roles(:spec).role_id }, current_user: @current_user)
      assert ctx.success?
      assert_equal [], ::MapGroupRole.where({ group_id: map_group_roles(:spec).group_id })
    end

    test 'Destroy No Data' do
      e = assert_raises InvalidParameters do
        Operation::Destroy.call(params: { group_id: -1, role_id: -1 }, current_user: @current_user)
      end
      assert_equal ['Group is invalid', 'Role is invalid'], JSON.parse(e.message)
    end
  end
end
