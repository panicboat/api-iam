require 'test_helper'

module MapRolePolicies
  class CreateTest < ActionDispatch::IntegrationTest
    setup do
      @role = ::Roles::Operation::Create.call({ params: { name: 'admin' } })
      @policy = ::Policies::Operation::Create.call({ params: { name: 'admin' } })
    end

    def default_params
      { role_id: @role[:model].id, policy_id: @policy[:model].id }
    end

    def expected_attrs
      { role_id: @role[:model].id, policy_id: @policy[:model].id }
    end

    test 'Create Data' do
      assert_pass Operation::Create, params({}), role_id: @role[:model].id
    end

    test 'Create Duplicate PolicyId' do
      Operation::Create.call(params: default_params)
      e = assert_raises InvalidParameters do
        Operation::Create.call(params: default_params)
      end
      assert_equal ['Policy Id has already been taken'], JSON.parse(e.message)
    end
  end
end
