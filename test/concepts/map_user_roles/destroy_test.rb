require 'test_helper'

module MapUserRoles
  class DestroyTest < ActionDispatch::IntegrationTest
    setup do
      @user = ::Users::Operation::Create.call({ params: { email: 'spec@panicboat.net', name: 'Spec' } })
      @role = ::Roles::Operation::Create.call({ params: { name: 'admin' } })
    end

    def default_params
      { user_id: @user[:model].id, role_id: @role[:model].id }
    end

    def expected_attrs
      { user_id: @user[:model].id, role_id: @role[:model].id }
    end

    test 'Destroy Data' do
      result = Operation::Create.call(params: default_params)
      assert_pass Operation::Destroy, params({ id: result[:model].id }), user_id: @user[:model].id
      assert_equal Operation::Index.call(params: { user_id: @user[:model].id })[:model].MapUserRoles, []
    end

    test 'Destroy No Data' do
      e = assert_raises InvalidParameters do
        Operation::Destroy.call(params: { user_id: '12345678-1234-1234-1234-123456789012', role_id: '12345678-1234-1234-1234-123456789012' })
      end
      assert_equal ['User role is invalid'], JSON.parse(e.message)
    end
  end
end
