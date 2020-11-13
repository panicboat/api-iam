require 'test_helper'

module Actions
  class DestroyTest < ActionDispatch::IntegrationTest
    setup do
      @service = ::Services::Operation::Create.call({ params: { name: 'iam' } })
    end

    def default_params
      { service_id: @service[:model].id, name: 'ListAction', description: 'action list', access_level: 'list' }
    end

    def expected_attrs
      { service_id: @service[:model].id, name: 'ListAction', description: 'action list', access_level: 'list' }
    end

    test 'Destroy Data' do
      result = Operation::Create.call(params: default_params)
      assert_pass Operation::Destroy, params({ id: result[:model].id }), name: 'ListAction'
      assert_equal Operation::Index.call(params: { service_id: @service[:model].id })[:model].Actions, []
    end

    test 'Destroy No Data' do
      e = assert_raises InvalidParameters do
        Operation::Destroy.call(params: { id: '12345678-1234-1234-1234-123456789012' })
      end
      assert_equal ['Parameters is invalid'], JSON.parse(e.message)
    end
  end
end
