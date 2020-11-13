require 'test_helper'

module MapUserPolicies
  class IndexTest < ActionDispatch::IntegrationTest
    setup do
      @user = ::Users::Operation::Create.call({ params: { email: 'spec@panicboat.net', name: 'Spec' } })
      @policy1 = ::Policies::Operation::Create.call({ params: { name: 'admin' } })
      @policy2 = ::Policies::Operation::Create.call({ params: { name: 'normal' } })
    end

    def default_params
      { user_id: @user[:model].id, policy_id: @policy1[:model].id }
    end

    def expected_attrs
      { user_id: @user[:model].id, policy_id: @policy2[:model].id }
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
