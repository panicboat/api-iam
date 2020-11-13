require 'test_helper'

module Policies
  class IndexTest < ActionDispatch::IntegrationTest
    def default_params
      { name: 'Administrators', description: 'can do anything', inline: false, owner: 'user', statements: [] }
    end

    def expected_attrs
      { name: 'Administrators', description: 'can do anything', inline: false, owner: 'user', statements: [] }
    end

    test 'Index Data' do
      Operation::Create.call(params: { name: 'admin', description: 'Spec1' })
      Operation::Create.call(params: { name: 'normal', description: 'Spec2' })
      ctx = Operation::Index.call(params: {})
      assert_equal ctx[:model].Policies.length, 2
      ctx[:model].Policies.each do |policy|
        assert_equal %w[admin normal].include?(policy.name), true
      end
    end

    test 'Index No Data' do
      assert_equal Operation::Index.call(params: {})[:model].Policies, []
    end
  end
end
