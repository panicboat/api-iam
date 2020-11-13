require 'test_helper'

module MapGroupPolicies
  class DestroyTest < ActionDispatch::IntegrationTest
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

    test 'Destroy Data' do
      Operation::Create.call(params: default_params)
      assert_pass Operation::Destroy, params({}), group_id: @group[:model].id
      assert_equal Operation::Index.call(params: { group_id: @group[:model].id })[:model].MapGroupPolicies, []
    end

    test 'Destroy No Data' do
      e = assert_raises InvalidParameters do
        Operation::Destroy.call(params: { group_id: '12345678-1234-1234-1234-123456789012', policy_id: '12345678-1234-1234-1234-123456789012' })
      end
      assert_equal ['Group Policy is invalid'], JSON.parse(e.message)
    end
  end
end
