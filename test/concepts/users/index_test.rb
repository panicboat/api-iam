require 'test_helper'

module Users
  class IndexTest < ActionDispatch::IntegrationTest
    fixtures :users

    setup do
      @current_user = JSON.parse({ name: 'Spec' }.to_json, object_class: OpenStruct)
      WebMock.stub_request(:get, "#{ENV['HTTP_IAM_URL']}/permissions/00000000-0000-0000-0000-000000000000").to_return(
        body: File.read("#{Rails.root}/test/fixtures/files/platform_iam_get_permission.json"),
        status: 200,
        headers: { 'Content-Type': 'application/json' }
      )
    end

    def default_params
      { id: '10000000-0000-0000-0000-000000000000', email: 'spec@panicboat.net', name: 'Spec' }
    end

    def expected_attrs
      { id: '10000000-0000-0000-0000-000000000000', email: 'spec@panicboat.net', name: 'Spec' }
    end

    test 'Index Data' do
      ctx = Operation::Index.call(params: {}, current_user: @current_user)
      assert ctx[:model].Users.present?
      assert_equal ::User.all.count, ctx[:model].Users.length
    end

    test 'Index No Data' do
      ::User.all.each(&:destroy)
      assert_equal [], Operation::Index.call(params: {}, current_user: @current_user)[:model].Users
    end
  end
end
