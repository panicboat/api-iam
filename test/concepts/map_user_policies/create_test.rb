require 'test_helper'

module MapUserPolicies
  class CreateTest < ActionDispatch::IntegrationTest
    fixtures :map_user_policies, :users, :policies

    setup do
      @current_user = JSON.parse({ name: 'Spec' }.to_json, object_class: OpenStruct)
      WebMock.stub_request(:get, "#{ENV['HTTP_IAM_URL']}/permissions/00000000-0000-0000-0000-000000000000").to_return(
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
        Operation::Create.call(params: default_params)
      end
      assert_equal ['Permissions is invalid'], JSON.parse(e.message)
    end

    test 'Create Data' do
      ctx = Operation::Create.call(params: default_params, current_user: @current_user)
      assert ctx.success?
      assert_equal users(:spec).id, ctx[:model].user_id
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
