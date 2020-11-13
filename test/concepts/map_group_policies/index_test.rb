require 'test_helper'

module MapGroupPolicies
  class IndexTest < ActionDispatch::IntegrationTest
    setup do
      @group = ::Groups::Operation::Create.call({ params: { name: 'admin' } })
      @policy1 = ::Policies::Operation::Create.call({ params: { name: 'admin' } })
      @policy2 = ::Policies::Operation::Create.call({ params: { name: 'normal' } })
    end

    def default_params
      { group_id: @group[:model].id, policy_id: @policy1[:model].id }
    end

    def expected_attrs
      { group_id: @group[:model].id, policy_id: @policy2[:model].id }
    end

    test 'Index Data' do
      Operation::Create.call(params: default_params)
      Operation::Create.call(params: default_params.merge({ policy_id: @policy2[:model].id }))
      ctx = Operation::Index.call(params: { group_id: @group[:model].id })
      assert_equal ctx[:model].MapGroupPolicies.length, 2
      ctx[:model].MapGroupPolicies.each do |map_group_policy|
        assert_equal [@policy1[:model].id, @policy2[:model].id].include?(map_group_policy.policy_id), true
      end
    end

    test 'Index No Data' do
      assert_equal Operation::Index.call(params: { group_id: @group[:model].id })[:model].MapGroupPolicies, []
    end
  end
end
