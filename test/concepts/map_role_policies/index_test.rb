require 'test_helper'

module MapRolePolicies
  class IndexTest < ActionDispatch::IntegrationTest
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

    test 'Index Data' do
      ctx = Operation::Index.call(params: { role_id: map_role_policies(:spec).role_id }, current_user: @current_user)
      assert ctx[:model].MapRolePolicies.present?
      assert_equal ::MapRolePolicy.all.count, ctx[:model].MapRolePolicies.length
    end

    test 'Index No Data' do
      role_id = map_role_policies(:spec).role_id
      ::MapRolePolicy.all.each(&:destroy)
      assert_equal [], Operation::Index.call(params: { role_id: role_id }, current_user: @current_user)[:model].MapRolePolicies
    end
  end
end
