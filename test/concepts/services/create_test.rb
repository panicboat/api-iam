require 'test_helper'

module Services
  class CreateTest < ActionDispatch::IntegrationTest
    def default_params
      { name: 'iam', description: 'API of Identity and Access Management.' }
    end

    def expected_attrs
      { name: 'iam', description: 'API of Identity and Access Management.' }
    end

    test 'Create Data' do
      assert_pass Operation::Create, params({}), name: 'iam'
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
