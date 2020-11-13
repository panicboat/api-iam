require 'test_helper'

class ServicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @service = ::Services::Operation::Create.call({ params: { name: 'iam', description: 'desc' } })
  end

  test 'Index' do
    get '/services'
    assert_response :success
  end

  test 'Show' do
    get "/services/#{@service[:model].id}"
    assert_response :success
  end

  test 'Create' do
    post '/services', params: { name: 'spec', description: 'desc' }
    assert_response :success
  end

  test 'Update' do
    patch "/services/#{@service[:model].id}", params: { name: 'spec' }
    assert_response :success
  end

  test 'Destroy' do
    delete "/services/#{@service[:model].id}"
    assert_response :success
  end
end
