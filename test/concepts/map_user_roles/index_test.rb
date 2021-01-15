require 'test_helper'

module MapUserRoles
  class IndexTest < ActionDispatch::IntegrationTest
    fixtures :map_user_roles, :users, :roles

    setup do
      @current_user = JSON.parse({ name: 'Spec' }.to_json, object_class: OpenStruct)
      WebMock.stub_request(:get, "#{ENV['HTTP_IAM_URL']}/permissions/00000000-0000-0000-0000-000000000000").to_return(
        body: File.read("#{Rails.root}/test/fixtures/files/platform_iam_get_permission.json"),
        status: 200,
        headers: { 'Content-Type': 'application/json' }
      )
    end

    def default_params
      { user_id: users(:spec).id, role_id: roles(:spec).id }
    end

    def expected_attrs
      { user_id: users(:spec).id, role_id: roles(:spec).id }
    end

    test 'Index Data' do
      ctx = Operation::Index.call(params: { user_id: map_user_roles(:spec).user_id }, current_user: @current_user)
      assert ctx[:model].MapUserRoles.present?
      assert_equal ::MapUserRole.all.count, ctx[:model].MapUserRoles.length
    end

    test 'Index No Data' do
      user_id = map_user_roles(:spec).user_id
      ::MapUserRole.all.each(&:destroy)
      assert_equal [], Operation::Index.call(params: { user_id: user_id }, current_user: @current_user)[:model].MapUserRoles
    end
  end
end
