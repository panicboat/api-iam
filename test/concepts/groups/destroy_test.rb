require 'test_helper'

module Groups
  class DestroyTest < ActionDispatch::IntegrationTest
    def default_params
      { name: 'admin', description: 'can do anything' }
    end

    def expected_attrs
      { name: 'admin', description: 'can do anything' }
    end

    test 'Destroy Data' do
      result = Operation::Create.call(params: default_params)
      assert_pass Operation::Destroy, params({ id: result[:model].id }), name: 'admin'
      assert_equal Operation::Index.call(params: {})[:model].Groups, []
    end

    test 'Destroy No Data' do
      e = assert_raises InvalidParameters do
        Operation::Destroy.call(params: { id: '12345678-1234-1234-1234-123456789012' })
      end
      assert_equal ['Parameters is invalid'], JSON.parse(e.message)
    end
  end
end
