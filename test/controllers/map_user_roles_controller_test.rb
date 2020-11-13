require 'test_helper'

class MapUserRolesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = ::Users::Operation::Create.call({ params: { email: 'spec@panicboat.net', name: 'Spec' } })
    @role1 = ::Roles::Operation::Create.call({ params: { name: 'admin' } })
    @role2 = ::Roles::Operation::Create.call({ params: { name: 'normal' } })
    @map = ::MapUserRoles::Operation::Create.call(params: { user_id: @user[:model].id, role_id: @role1[:model].id })
  end

  test 'Index' do
    get "/users/#{@user[:model].id}/roles"
    assert_response :success
  end

  test 'Create' do
    post "/users/#{@user[:model].id}/roles", params: { role_id: @role2[:model].id }
    assert_response :success
  end

  test 'Destroy' do
    delete "/users/#{@user[:model].id}/roles/#{@role1[:model].id}"
    assert_response :success
  end
end
