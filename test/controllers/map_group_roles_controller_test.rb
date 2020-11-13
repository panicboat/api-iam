require 'test_helper'

class MapGroupRolesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group = ::Groups::Operation::Create.call({ params: { name: 'admin' } })
    @role1 = ::Roles::Operation::Create.call({ params: { name: 'admin' } })
    @role2 = ::Roles::Operation::Create.call({ params: { name: 'normal' } })
    @map = ::MapGroupRoles::Operation::Create.call(params: { group_id: @group[:model].id, role_id: @role1[:model].id })
  end

  test 'Index' do
    get "/groups/#{@group[:model].id}/roles"
    assert_response :success
  end

  test 'Create' do
    post "/groups/#{@group[:model].id}/roles", params: { role_id: @role2[:model].id }
    assert_response :success
  end

  test 'Destroy' do
    delete "/groups/#{@group[:model].id}/roles/#{@role1[:model].id}"
    assert_response :success
  end
end
