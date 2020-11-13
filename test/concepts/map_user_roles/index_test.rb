require 'test_helper'

module MapUserRoles
  class IndexTest < ActionDispatch::IntegrationTest
    setup do
      @user = ::Users::Operation::Create.call({ params: { email: 'spec@panicboat.net', name: 'Spec' } })
      @role1 = ::Roles::Operation::Create.call({ params: { name: 'admin' } })
      @role2 = ::Roles::Operation::Create.call({ params: { name: 'normal' } })
    end

    def default_params
      { user_id: @user[:model].id, role_id: @role1[:model].id }
    end

    def expected_attrs
      { user_id: @user[:model].id, role_id: @role2[:model].id }
    end

    test 'Index Data' do
      Operation::Create.call(params: default_params)
      Operation::Create.call(params: default_params.merge({ role_id: @role2[:model].id }))
      ctx = Operation::Index.call(params: { user_id: @user[:model].id })
      assert_equal ctx[:model].MapUserRoles.length, 2
      ctx[:model].MapUserRoles.each do |map_user_role|
        assert_equal [@role1[:model].id, @role2[:model].id].include?(map_user_role.role_id), true
      end
    end

    test 'Index No Data' do
      assert_equal Operation::Index.call(params: { user_id: @user[:model].id })[:model].MapUserRoles, []
    end
  end
end
