require 'test_helper'

module Services
  class DestroyTest < ActionDispatch::IntegrationTest
    def default_params
      { name: 'iam', description: 'API of Identity and Access Management.' }
    end

    def expected_attrs
      { name: 'iam', description: 'API of Identity and Access Management.' }
    end

    test 'Destroy Data' do
      result = Operation::Create.call(params: default_params)
      assert_pass Operation::Destroy, params({ id: result[:model].id }), name: 'iam'
      assert_equal Operation::Index.call(params: {})[:model].Services, []
    end

    test 'Destroy No Data' do
      e = assert_raises InvalidParameters do
        Operation::Destroy.call(params: { id: '12345678-1234-1234-1234-123456789012' })
      end
      assert_equal ['Parameters is invalid'], JSON.parse(e.message)
    end
  end
end
