require 'test_helper'

module Members
  class IndexTest < ActionDispatch::IntegrationTest
    def default_params
      { email: 'spec@panicboat.net', name: 'Spec' }
    end

    def expected_attrs
      { email: 'spec@panicboat.net', name: 'Spec' }
    end

    test 'Index Data' do
      Operation::Create.call(params: { email: 'spec1@panicboat.net', name: 'Spec1' })
      Operation::Create.call(params: { email: 'spec2@panicboat.net', name: 'Spec2' })
      ctx = Operation::Index.call(params: {})
      assert_equal ctx[:model].Members.length, 2
      ctx[:model].Members.each do |user|
        assert_equal ['spec1@panicboat.net', 'spec2@panicboat.net'].include?(user.email), true
      end
    end

    test 'Index No Data' do
      assert_equal Operation::Index.call(params: {})[:model].Members, []
    end
  end
end
