require 'test_helper'

module Permissions
  class IndexTest < ActionDispatch::IntegrationTest
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
      ctx = Operation::Index.call(params: {}, current_user: users(:standalone))
      assert_equal 5, ctx[:model].Permissions.length
      ctx[:model].Permissions.each do |permission|
        assert_equal true, @permissions.include?(permission)
      end
    end

    test 'Check UserPolicy' do
      ::MapUserPolicy.new(user_id: users(:standalone).id, policy_id: policies(:standalone).id).save!
      ctx = Operation::Index.call(params: {}, current_user: users(:standalone))
      assert_equal 5, ctx[:model].Permissions.length
      ctx[:model].Permissions.each do |permission|
        assert_equal true, @permissions.include?(permission)
      end
    end

    test 'Check GroupRole' do
      ::MapGroupRole.new(group_id: groups(:standalone).id, role_id: roles(:standalone).id).save!
      ctx = Operation::Index.call(params: {}, current_user: users(:standalone))
      assert_equal 5, ctx[:model].Permissions.length
      ctx[:model].Permissions.each do |permission|
        assert_equal true, @permissions.include?(permission)
      end
    end

    test 'Check GroupPolicy' do
      ::MapGroupPolicy.new(group_id: groups(:standalone).id, policy_id: policies(:standalone).id).save!
      ctx = Operation::Index.call(params: {}, current_user: users(:standalone))
      assert_equal 5, ctx[:model].Permissions.length
      ctx[:model].Permissions.each do |permission|
        assert_equal true, @permissions.include?(permission)
      end
    end
  end
end
