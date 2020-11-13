require 'test_helper'

module MapGroupUsers
  class IndexTest < ActionDispatch::IntegrationTest
    setup do
      @group = ::Groups::Operation::Create.call({ params: { name: 'admin' } })
      @user1 = ::Users::Operation::Create.call({ params: { email: 'spec1@panicboat.net', name: 'Spec1' } })
      @user2 = ::Users::Operation::Create.call({ params: { email: 'spec2@panicboat.net', name: 'Spec2' } })
    end

    def default_params
      { group_id: @group[:model].id, user_id: @user1[:model].id }
    end

    def expected_attrs
      { group_id: @group[:model].id, user_id: @user2[:model].id }
    end

    test 'Index Data' do
      Operation::Create.call(params: default_params)
      Operation::Create.call(params: default_params.merge({ user_id: @user2[:model].id }))
      ctx = Operation::Index.call(params: { group_id: @group[:model].id })
      assert_equal ctx[:model].MapGroupUsers.length, 2
      ctx[:model].MapGroupUsers.each do |map_group_user|
        assert_equal [@user1[:model].id, @user2[:model].id].include?(map_group_user.user_id), true
      end
    end

    test 'Index No Data' do
      assert_equal Operation::Index.call(params: { group_id: @group[:model].id })[:model].MapGroupUsers, []
    end
  end
end
