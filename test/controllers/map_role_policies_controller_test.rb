require 'test_helper'

class MapRolePoliciesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @role = ::Roles::Operation::Create.call({ params: { name: 'admin', description: 'desc' } })
    @policy1 = ::Policies::Operation::Create.call({ params: { name: 'admin', inline: false, owner: 'user', statements: [] } })
    @policy2 = ::Policies::Operation::Create.call({ params: { name: 'normal', inline: false, owner: 'user', statements: [] } })
    @map = ::MapRolePolicies::Operation::Create.call(params: { role_id: @role[:model].id, policy_id: @policy1[:model].id })
  end

  test 'Index' do
    get "/roles/#{@role[:model].id}/policies"
    assert_response :success
  end

  test 'Create' do
    post "/roles/#{@role[:model].id}/policies", params: { policy_id: @policy2[:model].id }
    assert_response :success
  end

  test 'Destroy' do
    delete "/roles/#{@role[:model].id}/policies/#{@policy1[:model].id}"
    assert_response :success
  end
end
