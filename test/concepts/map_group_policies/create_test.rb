require 'test_helper'

module MapGroupPolicies
  class CreateTest < ActionDispatch::IntegrationTest
    setup do
      @group = ::Groups::Operation::Create.call({ params: { name: 'admin' } })
      @policy = ::Policies::Operation::Create.call({ params: { name: 'admin' } })
    end

    def default_params
      { group_id: @group[:model].id, policy_id: @policy[:model].id }
    end

    def expected_attrs
      { group_id: @group[:model].id, policy_id: @policy[:model].id }
    end

    test 'Create Data' do
      assert_pass Operation::Create, params({}), group_id: @group[:model].id
    end

    test 'Create Duplicate PolicyId' do
      Operation::Create.call(params: default_params)
      e = assert_raises InvalidParameters do
        Operation::Create.call(params: default_params)
      end
      assert_equal ['Policy has already been taken'], JSON.parse(e.message)
    end
  end
end
