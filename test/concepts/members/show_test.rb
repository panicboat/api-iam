require 'test_helper'

module Members
  class ShowTest < ActionDispatch::IntegrationTest
    def default_params
      { email: 'spec@panicboat.net', name: 'Spec' }
    end

    def expected_attrs
      { email: 'spec@panicboat.net', name: 'Spec' }
    end

    test 'Show Data' do
      result = Operation::Create.call(params: default_params)
      assert_pass Operation::Show, params({ id: result[:model].id }), email: 'spec@panicboat.net'
    end

    test 'Show No Data' do
      e = assert_raises InvalidParameters do
        Operation::Show.call(params: { id: '12345678-1234-1234-1234-123456789012' })
      end
      assert_equal ['Parameters is invalid'], JSON.parse(e.message)
    end
  end
end
