require 'test_helper'

module MapGroupRoles
  class IndexTest < ActionDispatch::IntegrationTest
    fixtures :map_group_roles, :groups, :roles

    setup do
      @current_user = JSON.parse({ name: 'Spec' }.to_json, object_class: OpenStruct)
      WebMock.stub_request(:get, "#{ENV['HTTP_IAM_URL']}/permissions/00000000-0000-0000-0000-000000000000").to_return(
        body: File.read("#{Rails.root}/test/fixtures/files/platform_iam_get_permission.json"),
        status: 200,
        headers: { 'Content-Type': 'application/json' }
      )
    end

    def default_params
      { group_id: groups(:spec).id, role_id: roles(:spec).id }
    end

    def expected_attrs
      { group_id: groups(:spec).id, role_id: roles(:spec).id }
    end

    test 'Index Data' do
      ctx = Operation::Index.call(params: { group_id: map_group_roles(:spec).group_id }, current_user: @current_user)
      assert ctx[:model].MapGroupRoles.present?
      assert_equal ::MapGroupRole.all.count, ctx[:model].MapGroupRoles.length
    end

    test 'Index No Data' do
      group_id = map_group_roles(:spec).group_id
      ::MapGroupRole.all.each(&:destroy)
      assert_equal [], Operation::Index.call(params: { group_id: group_id }, current_user: @current_user)[:model].MapGroupRoles
    end
  end
end
