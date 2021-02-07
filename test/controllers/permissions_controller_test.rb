require 'test_helper'

class PermissionsControllerTest < ActionDispatch::IntegrationTest
  fixtures :actions, :users

  def setup
    @options = { action: '00000000-0000-0000-0000-000000000000', current_user: users(:standalone) }
  end

  test 'Index' do
    ::Panicboat::AbstractController.stub_any_instance(:_options, @options) do
      get '/permissions'
    end
    assert_response :success
  end

  test 'Show' do
    ::Panicboat::AbstractController.stub_any_instance(:_options, @options) do
      get "/permissions/#{actions(:read).id}"
    end
    assert_response :success
  end
end
