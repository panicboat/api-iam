require 'test_helper'

module Services
  class IndexTest < ActionDispatch::IntegrationTest
    def default_params
      { name: 'iam', description: 'API of Identity and Access Management.' }
    end

    def expected_attrs
      { name: 'iam', description: 'API of Identity and Access Management.' }
    end

    test 'Index Data' do
      Operation::Create.call(params: { name: 'iam1', description: 'Spec1' })
      Operation::Create.call(params: { name: 'iam2', description: 'Spec2' })
      ctx = Operation::Index.call(params: {})
      assert_equal ctx[:model].Services.length, 2
      ctx[:model].Services.each do |service|
        assert_equal %w[iam1 iam2].include?(service.name), true
      end
    end

    test 'Index No Data' do
      assert_equal Operation::Index.call(params: {})[:model].Services, []
    end
  end
end
