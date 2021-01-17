require 'test_helper'

class MapGroupUsersControllerTest < ActionDispatch::IntegrationTest
  fixtures :groups, :users, :map_group_users, :users

  def setup
    @options = { action: '00000000-0000-0000-0000-000000000000', current_user: users(:standalone) }
    WebMock.stub_request(:get, %r{#{ENV['HTTP_IAM_URL']}/permissions/}).to_return(
      body: File.read("#{Rails.root}/test/fixtures/files/platform_iam_get_permission.json"),
      status: 200,
      headers: { 'Content-Type': 'application/json' }
    )
  end

  test 'Index' do
    ::ApplicationController.stub_any_instance(:_options, @options) do
      get "/groups/#{groups(:spec).id}/users"
    end
    assert_response :success
  end

  test 'Create' do
    ::ApplicationController.stub_any_instance(:_options, @options) do
      post "/groups/#{groups(:spec).id}/users", params: { user_id: users(:spec).id }
    end
    assert_response :success
  end

  test 'Destroy' do
    ::ApplicationController.stub_any_instance(:_options, @options) do
      delete "/groups/#{map_group_users(:spec).group_id}/users/#{map_group_users(:spec).user_id}"
    end
    assert_response :success
  end
end
