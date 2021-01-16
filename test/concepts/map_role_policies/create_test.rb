require 'test_helper'

module MapRolePolicies
  class CreateTest < ActionDispatch::IntegrationTest
    fixtures :map_role_policies, :roles, :policies

    setup do
      @current_user = JSON.parse({ name: 'Spec' }.to_json, object_class: OpenStruct)
      WebMock.stub_request(:get, %r{#{ENV['HTTP_IAM_URL']}/permissions/}).to_return(
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
        Operation::Create.call(params: default_params)
      end
      assert_equal ['Permissions is invalid'], JSON.parse(e.message)
    end

    test 'Create Data' do
      ctx = Operation::Create.call(params: default_params, current_user: @current_user)
      assert ctx.success?
      assert_equal roles(:spec).id, ctx[:model].role_id
      assert_equal policies(:spec).id, ctx[:model].policy_id
    end

    test 'Create Duplicate Policy' do
      Operation::Create.call(params: default_params, current_user: @current_user)
      e = assert_raises InvalidParameters do
        Operation::Create.call(params: default_params, current_user: @current_user)
      end
      assert_equal ['Policy has already been taken'], JSON.parse(e.message)
    end
  end
end
