require 'test_helper'

module Permissions
  class IndexTest < ActionDispatch::IntegrationTest
    setup do
      service1 = ::Services::Operation::Create.call(params: { name: 'iam' })
      service2 = ::Services::Operation::Create.call(params: { name: 'spec' })
      ::Actions::Operation::Create.call(params: { service_id: service1[:model].id, name: 'IamAction', access_level: 'write' })
      ::Actions::Operation::Create.call(params: { service_id: service2[:model].id, name: 'SpecAction', access_level: 'write' })
      @user = ::Users::Operation::Create.call({ params: { email: 'spec@panicboat.net', name: 'Spec' } })
      @group1 = ::Groups::Operation::Create.call(params: { name: 'group1' })
      @group2 = ::Groups::Operation::Create.call(params: { name: 'group2' })
      @policy1 = ::Policies::Operation::Create.call(params: { name: 'SpecPolicy1', statements: [{ effect: 'allow', actions: ['iam:*'], resources: ['prn:panicboat:platform:iam:group/bc2edb53-551c-*'] }] })
      @policy2 = ::Policies::Operation::Create.call(params: { name: 'SpecPolicy2', statements: [{ effect: 'allow', actions: ['spec:*'], resources: ['*'] }] })
      @role1 = ::Roles::Operation::Create.call(params: { name: 'SpecRole1' })
      @role2 = ::Roles::Operation::Create.call(params: { name: 'SpecRole2' })
      ::MapRolePolicies::Operation::Create.call(params: { role_id: @role1[:model].id, policy_id: @policy1[:model].id })
      ::MapRolePolicies::Operation::Create.call(params: { role_id: @role2[:model].id, policy_id: @policy2[:model].id })
    end

    def default_params
      {}
    end

    def expected_attrs
      {}
    end

    test 'Check UserRole' do
      ::MapUserRoles::Operation::Create.call(params: { user_id: @user[:model].id, role_id: @role1[:model].id })
      ::MapUserRoles::Operation::Create.call(params: { user_id: @user[:model].id, role_id: @role2[:model].id })
      ctx = Operation::Index.call(params: {}, current_user: @user[:model])
      assert_equal ctx[:model].Permissions.length, 2
      ctx[:model].Permissions.each do |permission|
        assert_equal ['iam:IamAction', 'spec:SpecAction'].include?(permission), true
      end
    end

    test 'Check UserPolicy' do
      ::MapUserPolicies::Operation::Create.call(params: { user_id: @user[:model].id, policy_id: @policy1[:model].id })
      ::MapUserPolicies::Operation::Create.call(params: { user_id: @user[:model].id, policy_id: @policy2[:model].id })
      ctx = Operation::Index.call(params: {}, current_user: @user[:model])
      assert_equal ctx[:model].Permissions.length, 2
      ctx[:model].Permissions.each do |permission|
        assert_equal ['iam:IamAction', 'spec:SpecAction'].include?(permission), true
      end
    end

    test 'Check GroupRole' do
      ::MapGroupUsers::Operation::Create.call(params: { group_id: @group1[:model].id, user_id: @user[:model].id })
      ::MapGroupUsers::Operation::Create.call(params: { group_id: @group2[:model].id, user_id: @user[:model].id })
      ::MapGroupRoles::Operation::Create.call(params: { group_id: @group1[:model].id, role_id: @role1[:model].id })
      ::MapGroupRoles::Operation::Create.call(params: { group_id: @group2[:model].id, role_id: @role2[:model].id })
      ctx = Operation::Index.call(params: {}, current_user: @user[:model])
      assert_equal ctx[:model].Permissions.length, 2
      ctx[:model].Permissions.each do |permission|
        assert_equal ['iam:IamAction', 'spec:SpecAction'].include?(permission), true
      end
    end

    test 'Check GroupPolicy' do
      ::MapGroupUsers::Operation::Create.call(params: { group_id: @group1[:model].id, user_id: @user[:model].id })
      ::MapGroupUsers::Operation::Create.call(params: { group_id: @group2[:model].id, user_id: @user[:model].id })
      ::MapGroupPolicies::Operation::Create.call(params: { group_id: @group1[:model].id, policy_id: @policy1[:model].id })
      ::MapGroupPolicies::Operation::Create.call(params: { group_id: @group2[:model].id, policy_id: @policy2[:model].id })
      ctx = Operation::Index.call(params: {}, current_user: @user[:model])
      assert_equal ctx[:model].Permissions.length, 2
      ctx[:model].Permissions.each do |permission|
        assert_equal ['iam:IamAction', 'spec:SpecAction'].include?(permission), true
      end
    end
  end
end
