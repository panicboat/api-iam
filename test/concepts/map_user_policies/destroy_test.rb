require 'test_helper'

module MapUserPolicies
  class DestroyTest < ActionDispatch::IntegrationTest
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

    test 'Destroy Data' do
      Operation::Create.call(params: default_params)
      assert_pass Operation::Destroy, params({}), user_id: @user[:model].id
      assert_equal Operation::Index.call(params: default_params)[:model].MapUserPolicies, []
    end

    test 'Destroy No Data' do
      e = assert_raises InvalidParameters do
        Operation::Destroy.call(params: { user_id: '12345678-1234-1234-1234-123456789012', policy_id: '12345678-1234-1234-1234-123456789012' })
      end
      assert_equal ['User policy is invalid'], JSON.parse(e.message)
    end
  end
end
