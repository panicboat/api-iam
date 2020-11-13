require 'test_helper'

class MapUserPoliciesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = ::Users::Operation::Create.call({ params: { email: 'spec@panicboat.net', name: 'Spec' } })
    @policy1 = ::Policies::Operation::Create.call({ params: { name: 'admin', inline: false, owner: 'user', statements: [] } })
    @policy2 = ::Policies::Operation::Create.call({ params: { name: 'normal', inline: false, owner: 'user', statements: [] } })
    @map = ::MapUserPolicies::Operation::Create.call(params: { user_id: @user[:model].id, policy_id: @policy1[:model].id })
  end

  test 'Index' do
    get "/users/#{@user[:model].id}/policies"
    assert_response :success
  end

  test 'Create' do
    post "/users/#{@user[:model].id}/policies", params: { policy_id: @policy2[:model].id }
    assert_response :success
  end

  test 'Destroy' do
    delete "/users/#{@user[:model].id}/policies/#{@policy1[:model].id}"
    assert_response :success
  end
end
