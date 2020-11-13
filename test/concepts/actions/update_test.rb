require 'test_helper'

module Actions
  class UpdateTest < ActionDispatch::IntegrationTest
    setup do
      @service = ::Services::Operation::Create.call({ params: { name: 'iam' } })
    end

    def default_params
      { service_id: @service[:model].id, name: 'ListAction', description: 'action list', access_level: 'list' }
    end

    def expected_attrs
      { service_id: @service[:model].id, name: 'ListAction', description: 'action list', access_level: 'list' }
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
