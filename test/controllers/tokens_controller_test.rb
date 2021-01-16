require 'test_helper'

class TokensControllerTest < ActionDispatch::IntegrationTest
  fixtures :users

  test 'Index' do
    ::ApplicationController.stub_any_instance(:_session, users(:standalone)) do
      get '/tokens'
    end
    assert_response :success
  end
end
