require 'test_helper'

class GroupsControllerTest < ActionDispatch::IntegrationTest
  fixtures :groups, :users

  def setup
    WebMock.stub_request(:get, "#{ENV['HTTP_IAM_URL']}/permissions/00000000-0000-0000-0000-000000000000").to_return(
      body: File.read("#{Rails.root}/test/fixtures/files/platform_iam_get_permission.json"),
      status: 200,
      headers: { 'Content-Type': 'application/json' }
    )
  end

  test 'Index' do
    ::ApplicationController.stub_any_instance(:_session, users(:standalone)) do
      get '/groups'
    end
    assert_response :success
  end

  test 'Show' do
    ::ApplicationController.stub_any_instance(:_session, users(:standalone)) do
      get "/groups/#{groups(:spec).id}"
    end
    assert_response :success
  end

  test 'Create' do
    ::ApplicationController.stub_any_instance(:_session, users(:standalone)) do
      post '/groups', params: { name: 'spec', description: 'desc' }
    end
    assert_response :success
  end

  test 'Update' do
    ::ApplicationController.stub_any_instance(:_session, users(:standalone)) do
      patch "/groups/#{groups(:spec).id}", params: { name: 'spec' }
    end
    assert_response :success
  end

  test 'Destroy' do
    ::ApplicationController.stub_any_instance(:_session, users(:standalone)) do
      delete "/groups/#{groups(:spec).id}"
    end
    assert_response :success
  end
end
