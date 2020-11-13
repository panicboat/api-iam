require 'test_helper'

module MapGroupRoles
  class IndexTest < ActionDispatch::IntegrationTest
    setup do
      @group = ::Groups::Operation::Create.call({ params: { name: 'admin' } })
      @role1 = ::Roles::Operation::Create.call({ params: { name: 'admin' } })
      @role2 = ::Roles::Operation::Create.call({ params: { name: 'normal' } })
    end

    def default_params
      { group_id: @group[:model].id, role_id: @role1[:model].id }
    end

    def expected_attrs
      { group_id: @group[:model].id, role_id: @role2[:model].id }
    end

    test 'Index Data' do
      Operation::Create.call(params: default_params)
      Operation::Create.call(params: default_params.merge({ role_id: @role2[:model].id }))
      ctx = Operation::Index.call(params: { group_id: @group[:model].id })
      assert_equal ctx[:model].MapGroupRoles.length, 2
      ctx[:model].MapGroupRoles.each do |map_group_role|
        assert_equal [@role1[:model].id, @role2[:model].id].include?(map_group_role.role_id), true
      end
    end

    test 'Index No Data' do
      assert_equal Operation::Index.call(params: { group_id: @group[:model].id })[:model].MapGroupRoles, []
    end
  end
end
