require 'test_helper'

module Roles
  class IndexTest < ActionDispatch::IntegrationTest
    def default_params
      { name: 'admin', description: 'can do anything', owner: 'user' }
    end

    def expected_attrs
      { name: 'admin', description: 'can do anything', owner: 'user' }
    end

    test 'Index Data' do
      Operation::Create.call(params: { name: 'admin', description: 'Spec1' })
      Operation::Create.call(params: { name: 'normal', description: 'Spec2' })
      ctx = Operation::Index.call(params: {})
      assert_equal ctx[:model].Roles.length, 2
      ctx[:model].Roles.each do |role|
        assert_equal %w[admin normal].include?(role.name), true
      end
    end

    test 'Index No Data' do
      assert_equal Operation::Index.call(params: {})[:model].Roles, []
    end
  end
end
