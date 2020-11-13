require 'test_helper'

class MembersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @member = ::Members::Operation::Create.call({ params: { email: 'spec@panicboat.net', name: 'Spec' } })
  end

  test 'Index' do
    get '/members'
    assert_response :success
  end

  test 'Show' do
    get "/members/#{@member[:model].id}"
    assert_response :success
  end

  test 'Create' do
    post '/members', params: { email: 'spec1@panicboat.net', name: 'Spec1' }
    assert_response :success
  end

  test 'Update' do
    patch "/members/#{@member[:model].id}", params: { name: 'Spec9999' }
    assert_response :success
  end

  test 'Destroy' do
    delete "/members/#{@member[:model].id}"
    assert_response :success
  end
end
