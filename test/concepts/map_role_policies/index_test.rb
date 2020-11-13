require 'test_helper'

module MapRolePolicies
  class IndexTest < ActionDispatch::IntegrationTest
    setup do
      @role = ::Roles::Operation::Create.call({ params: { name: 'admin' } })
      @policy1 = ::Policies::Operation::Create.call({ params: { name: 'admin' } })
      @policy2 = ::Policies::Operation::Create.call({ params: { name: 'normal' } })
    end

    def default_params
      { role_id: @role[:model].id, policy_id: @policy1[:model].id }
    end

    def expected_attrs
      { role_id: @role[:model].id, policy_id: @policy2[:model].id }
    end

    test 'Index Data' do
      Operation::Create.call(params: default_params)
      Operation::Create.call(params: default_params.merge({ policy_id: @policy2[:model].id }))
      ctx = Operation::Index.call(params: { role_id: @role[:model].id })
      assert_equal ctx[:model].MapRolePolicies.length, 2
      ctx[:model].MapRolePolicies.each do |map_role_policy|
        assert_equal [@policy1[:model].id, @policy2[:model].id].include?(map_role_policy.policy_id), true
      end
    end

    test 'Index No Data' do
      assert_equal Operation::Index.call(params: { role_id: @role[:model].id })[:model].MapRolePolicies, []
    end
  end
end
