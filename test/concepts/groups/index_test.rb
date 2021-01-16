require 'test_helper'

module Groups
  class IndexTest < ActionDispatch::IntegrationTest
    fixtures :groups

    setup do
      @current_user = JSON.parse({ name: 'Spec' }.to_json, object_class: OpenStruct)
      WebMock.stub_request(:get, %r{#{ENV['HTTP_IAM_URL']}/permissions/}).to_return(
        body: File.read("#{Rails.root}/test/fixtures/files/platform_iam_get_permission.json"),
        status: 200,
        headers: { 'Content-Type': 'application/json' }
      )
    end

    def default_params
      { id: '10000000-0000-0000-0000-000000000000', name: 'GroupSpec', description: 'can do anything' }
    end

    def expected_attrs
      { id: '10000000-0000-0000-0000-000000000000', name: 'GroupSpec', description: 'can do anything' }
    end

    test 'Index Data' do
      ctx = Operation::Index.call(params: {}, current_user: @current_user)
      assert ctx[:model].Groups.present?
      assert_equal ::Group.all.count, ctx[:model].Groups.length
    end

    test 'Index No Data' do
      ::Group.all.each(&:destroy)
      assert_equal [], Operation::Index.call(params: {}, current_user: @current_user)[:model].Groups
    end
  end
end
