require 'test_helper'

module Members
  class CreateTest < ActionDispatch::IntegrationTest
    def default_params
      { email: 'spec@panicboat.net', name: 'Spec' }
    end

    def expected_attrs
      { email: 'spec@panicboat.net', name: 'Spec' }
    end

    test 'Create Data' do
      assert_pass Operation::Create, params({}), email: 'spec@panicboat.net'
    end

    test 'Create Duplicate Email' do
      Operation::Create.call(params: default_params)
      e = assert_raises InvalidParameters do
        Operation::Create.call(params: default_params)
      end
      assert_equal ['Email has already been taken'], JSON.parse(e.message)
    end
  end
end
