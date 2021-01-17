require 'test_helper'

module MapGroupPolicies
  class IndexTest < ActionDispatch::IntegrationTest
    fixtures :map_group_policies, :groups, :policies

    setup do
      @current_user = JSON.parse({ name: 'Spec' }.to_json, object_class: OpenStruct)
      WebMock.stub_request(:get, %r{#{ENV['HTTP_IAM_URL']}/permissions/}).to_return(
        body: File.read("#{Rails.root}/test/fixtures/files/platform_iam_get_permission.json"),
        status: 200,
        headers: { 'Content-Type': 'application/json' }
      )
    end

    def default_params
      { group_id: groups(:spec).id, policy_id: policies(:spec).id }
    end

    def expected_attrs
      { group_id: groups(:spec).id, policy_id: policies(:spec).id }
    end

    test 'Index Data' do
      ctx = Operation::Index.call(params: { group_id: map_group_policies(:spec).group_id }, current_user: @current_user, action: 'DUMMY_ACTION_ID')
      assert ctx[:model].MapGroupPolicies.present?
      assert_equal ::MapGroupPolicy.all.count, ctx[:model].MapGroupPolicies.length
    end

    test 'Index No Data' do
      group_id = map_group_policies(:spec).group_id
      ::MapGroupPolicy.all.each(&:destroy)
      assert_equal [], Operation::Index.call(params: { group_id: group_id }, current_user: @current_user, action: 'DUMMY_ACTION_ID')[:model].MapGroupPolicies
    end
  end
end
