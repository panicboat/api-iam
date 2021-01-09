require 'test_helper'

module MapUserPolicies
  class CreateTest < ActionDispatch::IntegrationTest
    setup do
      @user = ::Users::Operation::Create.call({ params: { email: 'spec@panicboat.net', name: 'Spec' } })
      @policy = ::Policies::Operation::Create.call({ params: { name: 'admin' } })
    end

    def default_params
      { user_id: @user[:model].id, policy_id: @policy[:model].id }
    end

    def expected_attrs
      { user_id: @user[:model].id, policy_id: @policy[:model].id }
    end

    test 'Create Data' do
      assert_pass Operation::Create, params({}), user_id: @user[:model].id
    end

    test 'Create Duplicate PolicyId' do
      Operation::Create.call(params: default_params)
      e = assert_raises InvalidParameters do
        Operation::Create.call(params: default_params)
      end
      assert_equal ['Policy has already been taken'], JSON.parse(e.message)
    end
  end
end
