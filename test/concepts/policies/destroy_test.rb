require 'test_helper'

module Policies
  class DestroyTest < ActionDispatch::IntegrationTest
    def default_params
      { name: 'Administrators', description: 'can do anything', inline: false, owner: 'user', statements: [] }
    end

    def expected_attrs
      { name: 'Administrators', description: 'can do anything', inline: false, owner: 'user', statements: [] }
    end

    test 'Destroy Data' do
      result = Operation::Create.call(params: default_params)
      assert_pass Operation::Destroy, params({ id: result[:model].id }), name: 'Administrators'
      assert_equal Operation::Index.call(params: {})[:model].Policies, []
    end

    test 'Destroy No Data' do
      e = assert_raises InvalidParameters do
        Operation::Destroy.call(params: { id: '12345678-1234-1234-1234-123456789012' })
      end
      assert_equal ['Parameters is invalid'], JSON.parse(e.message)
    end
  end
end
