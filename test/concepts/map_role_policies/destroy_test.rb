require 'test_helper'

module MapRolePolicies
  class DestroyTest < ActionDispatch::IntegrationTest
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

    test 'Destroy Data' do
      result = Operation::Create.call(params: default_params)
      assert_pass Operation::Destroy, params({ id: result[:model].id }), role_id: @role[:model].id
      assert_equal Operation::Index.call(params: { role_id: @role[:model].id })[:model].MapRolePolicies, []
    end

    test 'Destroy No Data' do
      e = assert_raises InvalidParameters do
        Operation::Destroy.call(params: { role_id: '12345678-1234-1234-1234-123456789012', policy_id: '12345678-1234-1234-1234-123456789012' })
      end
      assert_equal ['Role Policy is invalid'], JSON.parse(e.message)
    end
  end
end
