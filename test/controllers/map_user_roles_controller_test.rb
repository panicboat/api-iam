require 'test_helper'

class MapUserRolesControllerTest < ActionDispatch::IntegrationTest
  fixtures :users, :roles, :map_user_roles

  def setup
    WebMock.stub_request(:get, %r{#{ENV['HTTP_IAM_URL']}/permissions/}).to_return(
      body: File.read("#{Rails.root}/test/fixtures/files/platform_iam_get_permission.json"),
      status: 200,
      headers: { 'Content-Type': 'application/json' }
    )
  end

  test 'Index' do
    ::ApplicationController.stub_any_instance(:_session, users(:standalone)) do
      get "/users/#{users(:spec).id}/roles"
    end
    assert_response :success
  end

  test 'Create' do
    ::ApplicationController.stub_any_instance(:_session, users(:standalone)) do
      post "/users/#{users(:spec).id}/roles", params: { role_id: roles(:spec).id }
    end
    assert_response :success
  end

  test 'Destroy' do
    ::ApplicationController.stub_any_instance(:_session, users(:standalone)) do
      delete "/users/#{map_user_roles(:spec).user_id}/roles/#{map_user_roles(:spec).role_id}"
    end
    assert_response :success
  end
end
