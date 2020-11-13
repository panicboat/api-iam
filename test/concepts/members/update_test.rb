require 'test_helper'

module Members
  class UpdateTest < ActionDispatch::IntegrationTest
    def default_params
      { email: 'spec@panicboat.net', name: 'Spec' }
    end

    def expected_attrs
      { email: 'spec@panicboat.net', name: 'Spec' }
    end

    test 'Update Data' do
      result = Operation::Create.call(params: default_params)
      assert_pass Operation::Update, params({ id: result[:model].id, name: 'UpdateSpec' }), name: 'UpdateSpec'
    end

    test 'Show No Data' do
      e = assert_raises InvalidParameters do
        Operation::Update.call(params: { id: '12345678-1234-1234-1234-123456789012' })
      end
      assert_equal ['Parameters is invalid'], JSON.parse(e.message)
    end
  end
end
