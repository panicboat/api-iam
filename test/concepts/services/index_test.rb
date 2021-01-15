require 'test_helper'

module Services
  class IndexTest < ActionDispatch::IntegrationTest
    fixtures :services

    setup do
      @current_user = JSON.parse({ name: 'Spec' }.to_json, object_class: OpenStruct)
      WebMock.stub_request(:get, "#{ENV['HTTP_IAM_URL']}/permissions/00000000-0000-0000-0000-000000000000").to_return(
        body: File.read("#{Rails.root}/test/fixtures/files/platform_iam_get_permission.json"),
        status: 200,
        headers: { 'Content-Type': 'application/json' }
      )
    end

    def default_params
      { id: '10000000-0000-0000-0000-000000000000', name: 'Service', description: 'This is description' }
    end

    def expected_attrs
      { id: '10000000-0000-0000-0000-000000000000', name: 'Service', description: 'This is description' }
    end

    test 'Index Data' do
      ctx = Operation::Index.call(params: {}, current_user: @current_user)
      assert ctx[:model].Services.present?
      assert_equal ::Service.all.count, ctx[:model].Services.length
    end

    test 'Index No Data' do
      ::Service.all.each(&:destroy)
      assert_equal [], Operation::Index.call(params: {}, current_user: @current_user)[:model].Services
    end
  end
end
