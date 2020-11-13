require 'test_helper'

class GroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group = ::Groups::Operation::Create.call({ params: { name: 'admin', description: 'desc' } })
  end

  test 'Index' do
    get '/groups'
    assert_response :success
  end

  test 'Show' do
    get "/groups/#{@group[:model].id}"
    assert_response :success
  end

  test 'Create' do
    post '/groups', params: { name: 'spec', description: 'desc' }
    assert_response :success
  end

  test 'Update' do
    patch "/groups/#{@group[:model].id}", params: { name: 'spec' }
    assert_response :success
  end

  test 'Destroy' do
    delete "/groups/#{@group[:model].id}"
    assert_response :success
  end
end
