require 'test_helper'

module MapGroupUsers
  class IndexTest < ActionDispatch::IntegrationTest
    fixtures :map_group_users, :groups, :users

    setup do
      @current_user = JSON.parse({ name: 'Spec' }.to_json, object_class: OpenStruct)
      WebMock.stub_request(:get, "#{ENV['HTTP_IAM_URL']}/permissions/00000000-0000-0000-0000-000000000000").to_return(
        body: File.read("#{Rails.root}/test/fixtures/files/platform_iam_get_permission.json"),
        status: 200,
        headers: { 'Content-Type': 'application/json' }
      )
    end

    def default_params
      { group_id: groups(:spec).id, user_id: users(:spec).id }
    end

    def expected_attrs
      { group_id: groups(:spec).id, user_id: users(:spec).id }
    end

    test 'Index Data' do
      ctx = Operation::Index.call(params: { group_id: map_group_users(:spec).group_id }, current_user: @current_user)
      assert ctx[:model].MapGroupUsers.present?
      assert_equal ::MapGroupUser.all.count, ctx[:model].MapGroupUsers.length
    end

    test 'Index No Data' do
      group_id = map_group_users(:spec).group_id
      ::MapGroupUser.all.each(&:destroy)
      assert_equal [], Operation::Index.call(params: { group_id: group_id }, current_user: @current_user)[:model].MapGroupUsers
    end
  end
end
