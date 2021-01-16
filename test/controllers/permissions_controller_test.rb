require 'test_helper'

class PermissionsControllerTest < ActionDispatch::IntegrationTest
  fixtures :actions, :users

  test 'Index' do
    ::ApplicationController.stub_any_instance(:_session, users(:standalone)) do
      get '/permissions'
    end
    assert_response :success
  end

  test 'Show' do
    ::ApplicationController.stub_any_instance(:_session, users(:standalone)) do
      get "/permissions/#{actions(:read).id}"
    end
    assert_response :success
  end
end
