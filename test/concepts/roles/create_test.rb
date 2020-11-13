require 'test_helper'

module Roles
  class CreateTest < ActionDispatch::IntegrationTest
    def default_params
      { name: 'admin', description: 'can do anything', owner: 'user' }
    end

    def expected_attrs
      { name: 'admin', description: 'can do anything', owner: 'user' }
    end

    test 'Create Data' do
      assert_pass Operation::Create, params({ owner: 'pnb' }), name: 'admin', owner: 'pnb'
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