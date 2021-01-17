require 'test_helper'

module Roles
  class IndexTest < ActionDispatch::IntegrationTest
    fixtures :roles

    setup do
      @current_user = JSON.parse({ name: 'Spec' }.to_json, object_class: OpenStruct)
      WebMock.stub_request(:get, %r{#{ENV['HTTP_IAM_URL']}/permissions/}).to_return(
        body: File.read("#{Rails.root}/test/fixtures/files/platform_iam_get_permission.json"),
        status: 200,
        headers: { 'Content-Type': 'application/json' }
      )
    end

    def default_params
      { id: '10000000-0000-0000-0000-000000000000', name: 'RoleSpec', description: 'can do anything', owner: 'user' }
    end

    def expected_attrs
      { id: '10000000-0000-0000-0000-000000000000', name: 'RoleSpec', description: 'can do anything', owner: 'user' }
    end

    test 'Index Data' do
      ctx = Operation::Index.call(params: {}, current_user: @current_user, action: 'DUMMY_ACTION_ID')
      assert ctx[:model].Roles.present?
      assert_equal ::Role.all.count, ctx[:model].Roles.length
    end

    test 'Index No Data' do
      ::Role.all.each(&:destroy)
      assert_equal [], Operation::Index.call(params: {}, current_user: @current_user, action: 'DUMMY_ACTION_ID')[:model].Roles
    end
  end
end
