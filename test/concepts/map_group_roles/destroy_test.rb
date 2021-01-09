require 'test_helper'

module MapGroupRoles
  class DestroyTest < ActionDispatch::IntegrationTest
    setup do
      @group = ::Groups::Operation::Create.call({ params: { name: 'admin' } })
      @role = ::Roles::Operation::Create.call({ params: { name: 'admin' } })
    end

    def default_params
      { group_id: @group[:model].id, role_id: @role[:model].id }
    end

    def expected_attrs
      { group_id: @group[:model].id, role_id: @role[:model].id }
    end

    test 'Destroy Data' do
      result = Operation::Create.call(params: default_params)
      assert_pass Operation::Destroy, params({ id: result[:model].id }), group_id: @group[:model].id
      assert_equal Operation::Index.call(params: { group_id: @group[:model].id })[:model].MapGroupRoles, []
    end

    test 'Destroy No Data' do
      e = assert_raises InvalidParameters do
        Operation::Destroy.call(params: { group_id: '12345678-1234-1234-1234-123456789012', role_id: '12345678-1234-1234-1234-123456789012' })
      end
      assert_equal ['Group role is invalid'], JSON.parse(e.message)
    end
  end
end
