require 'test_helper'

class ActionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @service = ::Services::Operation::Create.call({ params: { name: 'iam', description: 'desc' } })
    @action = ::Actions::Operation::Create.call({ params: { service_id: @service[:model].id, name: 'GetAny', access_level: 'read' } })
  end

  test 'Index' do
    get "/services/#{@service[:model].id}/actions"
    assert_response :success
  end

  test 'Show' do
    get "/services/#{@service[:model].id}/actions/#{@action[:model].id}"
    assert_response :success
  end

  test 'Create' do
    post "/services/#{@service[:model].id}/actions", params: { name: 'spec', description: 'desc', access_level: 'list' }
    assert_response :success
  end

  test 'Update' do
    patch "/services/#{@service[:model].id}/actions/#{@action[:model].id}", params: { name: 'spec' }
    assert_response :success
  end

  test 'Destroy' do
    delete "/services/#{@service[:model].id}/actions/#{@action[:model].id}"
    assert_response :success
  end
end
