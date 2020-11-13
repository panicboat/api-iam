require 'test_helper'

module MapGroupUsers
  class CreateTest < ActionDispatch::IntegrationTest
    setup do
      @group = ::Groups::Operation::Create.call({ params: { name: 'admin' } })
      @user = ::Users::Operation::Create.call({ params: { email: 'spec@panicboat.net', name: 'Spec' } })
    end

    def default_params
      { group_id: @group[:model].id, user_id: @user[:model].id }
    end

    def expected_attrs
      { group_id: @group[:model].id, user_id: @user[:model].id }
    end

    test 'Create Data' do
      assert_pass Operation::Create, params({}), group_id: @group[:model].id
    end

    test 'Create Duplicate UserId' do
      Operation::Create.call(params: default_params)
      e = assert_raises InvalidParameters do
        Operation::Create.call(params: default_params)
      end
      assert_equal ['User Id has already been taken'], JSON.parse(e.message)
    end
  end
end
