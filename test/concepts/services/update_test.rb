require 'test_helper'

module Services
  class UpdateTest < ActionDispatch::IntegrationTest
    def default_params
      { name: 'iam', description: 'API of Identity and Access Management.' }
    end

    def expected_attrs
      { name: 'iam', description: 'API of Identity and Access Management.' }
    end

    test 'Update Data' do
      result = Operation::Create.call(params: default_params)
      assert_pass Operation::Update, params({ id: result[:model].id, name: 'This is description.' }), name: 'This is description.'
    end

    test 'Show No Data' do
      e = assert_raises InvalidParameters do
        Operation::Update.call(params: { id: '12345678-1234-1234-1234-123456789012' })
      end
      assert_equal ['Parameters is invalid'], JSON.parse(e.message)
    end
  end
end
