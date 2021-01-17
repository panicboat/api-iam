require 'test_helper'

class TokensControllerTest < ActionDispatch::IntegrationTest
  fixtures :users

  def setup
    @options = { action: '00000000-0000-0000-0000-000000000000', current_user: users(:standalone) }
  end

  test 'Index' do
    ::ApplicationController.stub_any_instance(:_options, @options) do
      get '/tokens'
    end
    assert_response :success
  end
end
