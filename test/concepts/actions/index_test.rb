require 'test_helper'

module Actions
  class IndexTest < ActionDispatch::IntegrationTest
    setup do
      @service = ::Services::Operation::Create.call({ params: { name: 'iam' } })
    end

    def default_params
      { service_id: @service[:model].id, name: 'ListAction', description: 'action list', access_level: 'list' }
    end

    def expected_attrs
      { service_id: @service[:model].id, name: 'ListAction', description: 'action list', access_level: 'list' }
    end

    test 'Index Data' do
      Operation::Create.call(params: default_params.merge({ name: 'ListAction' }))
      Operation::Create.call(params: default_params.merge({ name: 'GetAction' }))
      ctx = Operation::Index.call(params: { service_id: @service[:model].id })
      assert_equal ctx[:model].Actions.length, 2
      ctx[:model].Actions.each do |action|
        assert_equal %w[ListAction GetAction].include?(action.name), true
      end
    end

    test 'Index No Data' do
      assert_equal Operation::Index.call(params: { service_id: @service[:model].id })[:model].Actions, []
    end
  end
end
