require 'test_helper'

module Tokens
  class IndexTest < ActionDispatch::IntegrationTest
    def default_params
      {}
    end

    def expected_attrs
      {}
    end

    test 'Decode' do
      ctx = Operation::Index.call(params: {})
      assert_equal ctx[:model].status, Rack::Utils::SYMBOL_TO_STATUS_CODE[:ok]
    end
  end
end
