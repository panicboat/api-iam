require 'test_helper'

class PoliciesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @policy = ::Policies::Operation::Create.call({ params: { name: 'Administrators', inline: false, owner: 'user', statements: [] } })
  end

  test 'Index' do
    get '/policies'
    assert_response :success
  end

  test 'Show' do
    get "/policies/#{@policy[:model].id}"
    assert_response :success
  end

  test 'Create' do
    post '/policies', params: { name: 'spec', description: 'desc' }
    assert_response :success
  end

  test 'Update' do
    patch "/policies/#{@policy[:model].id}", params: { name: 'spec' }
    assert_response :success
  end

  test 'Destroy' do
    delete "/policies/#{@policy[:model].id}"
    assert_response :success
  end
end
