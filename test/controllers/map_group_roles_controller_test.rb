require 'test_helper'

class MapGroupRolesControllerTest < ActionDispatch::IntegrationTest
  fixtures :groups, :roles, :map_group_roles, :users

  def setup
    @options = { action: '00000000-0000-0000-0000-000000000000', current_user: users(:standalone) }
    WebMock.stub_request(:get, %r{#{ENV['HTTP_IAM_URL']}/permissions/}).to_return(
      body: File.read("#{Rails.root}/test/fixtures/files/platform_iam_get_permission.json"),
      status: 200,
      headers: { 'Content-Type': 'application/json' }
    )
  end

  test 'Index' do
    ::Panicboat::AbstractController.stub_any_instance(:_options, @options) do
      get "/groups/#{groups(:spec).id}/roles"
    end
    assert_response :success
  end

  test 'Create' do
    ::Panicboat::AbstractController.stub_any_instance(:_options, @options) do
      post "/groups/#{groups(:spec).id}/roles", params: { role_id: roles(:spec).id }
    end
    assert_response :success
  end

  test 'Destroy' do
    ::Panicboat::AbstractController.stub_any_instance(:_options, @options) do
      delete "/groups/#{map_group_roles(:spec).group_id}/roles/#{map_group_roles(:spec).role_id}"
    end
    assert_response :success
  end
end
