require 'test_helper'

module Groups
  class IndexTest < ActionDispatch::IntegrationTest
    def default_params
      { name: 'admin', description: 'can do anything' }
    end

    def expected_attrs
      { name: 'admin', description: 'can do anything' }
    end

    test 'Index Data' do
      Operation::Create.call(params: { name: 'admin', description: 'Spec1' })
      Operation::Create.call(params: { name: 'normal', description: 'Spec2' })
      ctx = Operation::Index.call(params: {})
      assert_equal ctx[:model].Groups.length, 2
      ctx[:model].Groups.each do |group|
        assert_equal %w[admin normal].include?(group.name), true
      end
    end

    test 'Index No Data' do
      assert_equal Operation::Index.call(params: {})[:model].Groups, []
    end
  end
end
