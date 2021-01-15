require 'test_helper'

module MapUserPolicies
  class IndexTest < ActionDispatch::IntegrationTest
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
      { user_id: users(:fixtures).id, policy_id: policies(:spec).id }
    end

    def expected_attrs
      { user_id: users(:fixtures).id, policy_id: policies(:spec).id }
    end

    test 'Index Data' do
      Operation::Create.call(params: default_params)
      Operation::Create.call(params: default_params.merge({ policy_id: @policy2[:model].id }))
      ctx = Operation::Index.call(params: { user_id: @user[:model].id })
      assert_equal ctx[:model].MapUserPolicies.length, 2
      ctx[:model].MapUserPolicies.each do |map_user_policy|
        assert_equal [@policy1[:model].id, @policy2[:model].id].include?(map_user_policy.policy_id), true
      end
    end

    test 'Index No Data' do
      assert_equal Operation::Index.call(params: { user_id: @user[:model].id })[:model].MapUserPolicies, []
    end
  end
end
