require 'test_helper'

class MapGroupPoliciesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group = ::Groups::Operation::Create.call({ params: { name: 'admin' } })
    @policy1 = ::Policies::Operation::Create.call({ params: { name: 'admin', inline: false, owner: 'user', statements: [] } })
    @policy2 = ::Policies::Operation::Create.call({ params: { name: 'normal', inline: false, owner: 'user', statements: [] } })
    @map = ::MapGroupPolicies::Operation::Create.call(params: { group_id: @group[:model].id, policy_id: @policy1[:model].id })
  end

  test 'Index' do
    get "/groups/#{@group[:model].id}/policies"
    assert_response :success
  end

  test 'Create' do
    post "/groups/#{@group[:model].id}/policies", params: { policy_id: @policy2[:model].id }
    assert_response :success
  end

  test 'Destroy' do
    delete "/groups/#{@group[:model].id}/policies/#{@policy1[:model].id}"
    assert_response :success
  end
end
