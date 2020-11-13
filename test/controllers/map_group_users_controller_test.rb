require 'test_helper'

class MapGroupUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group = ::Groups::Operation::Create.call({ params: { name: 'admin' } })
    @user1 = ::Users::Operation::Create.call({ params: { email: 'spec1@panicboat.net', name: 'Spec1' } })
    @user2 = ::Users::Operation::Create.call({ params: { email: 'spec2@panicboat.net', name: 'Spec2' } })
    @map = ::MapGroupUsers::Operation::Create.call(params: { group_id: @group[:model].id, user_id: @user1[:model].id })
  end

  test 'Index' do
    get "/groups/#{@group[:model].id}/users"
    assert_response :success
  end

  test 'Create' do
    post "/groups/#{@group[:model].id}/users", params: { user_id: @user2[:model].id }
    assert_response :success
  end

  test 'Destroy' do
    delete "/groups/#{@group[:model].id}/users/#{@user1[:model].id}"
    assert_response :success
  end
end
