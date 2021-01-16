require 'test_helper'

class MapGroupUsersControllerTest < ActionDispatch::IntegrationTest
  fixtures :groups, :users, :map_group_users, :users

  def setup
    WebMock.stub_request(:get, "#{ENV['HTTP_IAM_URL']}/permissions/00000000-0000-0000-0000-000000000000").to_return(
      body: File.read("#{Rails.root}/test/fixtures/files/platform_iam_get_permission.json"),
      status: 200,
      headers: { 'Content-Type': 'application/json' }
    )
  end

  test 'Index' do
    ::ApplicationController.stub_any_instance(:_session, users(:standalone)) do
      get "/groups/#{groups(:spec).id}/users"
    end
    assert_response :success
  end

  test 'Create' do
    ::ApplicationController.stub_any_instance(:_session, users(:standalone)) do
      post "/groups/#{groups(:spec).id}/users", params: { user_id: users(:spec).id }
    end
    assert_response :success
  end

  test 'Destroy' do
    ::ApplicationController.stub_any_instance(:_session, users(:standalone)) do
      delete "/groups/#{map_group_users(:spec).group_id}/users/#{map_group_users(:spec).user_id}"
    end
    assert_response :success
  end
end
