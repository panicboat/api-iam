require 'test_helper'

class RolesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @role = ::Roles::Operation::Create.call({ params: { name: 'admin', description: 'desc' } })
  end

  test 'Index' do
    get '/roles'
    assert_response :success
  end

  test 'Show' do
    get "/roles/#{@role[:model].id}"
    assert_response :success
  end

  test 'Create' do
    post '/roles', params: { name: 'spec', description: 'desc' }
    assert_response :success
  end

  test 'Update' do
    patch "/roles/#{@role[:model].id}", params: { name: 'spec' }
    assert_response :success
  end

  test 'Destroy' do
    delete "/roles/#{@role[:model].id}"
    assert_response :success
  end
end
