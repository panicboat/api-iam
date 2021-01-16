require 'test_helper'

module Permissions
  class ShowTest < ActionDispatch::IntegrationTest
    fixtures :users, :groups, :roles, :policies
    fixtures :services, :actions
    fixtures :statements, :resources, :map_statement_actions

    def setup
      @permissions = ['standalone:GetSpec', 'standalone:CreateSpec', 'standalone:UpdateSpec', 'standalone:DeleteSpec', 'standalone:ListSpec']
      ::MapGroupUser.new(group_id: groups(:standalone).id, user_id: users(:standalone).id).save!
      ::MapRolePolicy.new(role_id: roles(:standalone).id, policy_id: policies(:standalone).id).save!
    end

    def default_params
      {}
    end

    def expected_attrs
      {}
    end

    test 'Check UserRole' do
      ::MapUserRole.new(user_id: users(:standalone).id, role_id: roles(:standalone).id).save!
      ctx = Operation::Show.call(params: { id: actions(:read).id }, current_user: users(:standalone))
      assert_equal 1, ctx[:model].Permissions.length
      ctx[:model].Permissions.each do |permission|
        assert_equal permission.effect, 'allow'
        assert_equal permission.prn, ['prn:panicboat:platform:iam:role/00000000-0000-0000-0000-*']
      end
    end

    test 'Check UserPolicy' do
      ::MapUserPolicy.new(user_id: users(:standalone).id, policy_id: policies(:standalone).id).save!
      ctx = Operation::Show.call(params: { id: actions(:read).id }, current_user: users(:standalone))
      assert_equal 1, ctx[:model].Permissions.length
      ctx[:model].Permissions.each do |permission|
        assert_equal permission.effect, 'allow'
        assert_equal permission.prn, ['prn:panicboat:platform:iam:role/00000000-0000-0000-0000-*']
      end
    end

    test 'Check GroupRole' do
      ::MapGroupRole.new(group_id: groups(:standalone).id, role_id: roles(:standalone).id).save!
      ctx = Operation::Show.call(params: { id: actions(:read).id }, current_user: users(:standalone))
      assert_equal 1, ctx[:model].Permissions.length
      ctx[:model].Permissions.each do |permission|
        assert_equal permission.effect, 'allow'
        assert_equal permission.prn, ['prn:panicboat:platform:iam:role/00000000-0000-0000-0000-*']
      end
    end

    test 'Check GroupPolicy' do
      ::MapGroupPolicy.new(group_id: groups(:standalone).id, policy_id: policies(:standalone).id).save!
      ctx = Operation::Show.call(params: { id: actions(:read).id }, current_user: users(:standalone))
      assert_equal 1, ctx[:model].Permissions.length
      ctx[:model].Permissions.each do |permission|
        assert_equal permission.effect, 'allow'
        assert_equal permission.prn, ['prn:panicboat:platform:iam:role/00000000-0000-0000-0000-*']
      end
    end
  end
end
