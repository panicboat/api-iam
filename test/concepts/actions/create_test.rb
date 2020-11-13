require 'test_helper'

module Actions
  class CreateTest < ActionDispatch::IntegrationTest
    setup do
      @service = ::Services::Operation::Create.call({ params: { name: 'iam' } })
    end

    def default_params
      { service_id: @service[:model].id, name: 'ListAction', description: 'action list', access_level: 'list' }
    end

    def expected_attrs
      { service_id: @service[:model].id, name: 'ListAction', description: 'action list', access_level: 'list' }
    end

    test 'Create Data' do
      assert_pass Operation::Create, params({}), name: 'ListAction'
    end

    test 'Create Duplicate Name' do
      Operation::Create.call(params: default_params)
      e = assert_raises InvalidParameters do
        Operation::Create.call(params: default_params)
      end
      assert_equal ['Name has already been taken'], JSON.parse(e.message)
    end
  end
end
