require 'test_helper'

module Policies
  class DestroyTest < ActionDispatch::IntegrationTest
    fixtures :policies

    setup do
      @current_user = JSON.parse({ name: 'Spec' }.to_json, object_class: OpenStruct)
      WebMock.stub_request(:get, %r{#{ENV['HTTP_IAM_URL']}/permissions/}).to_return(
        body: File.read("#{Rails.root}/test/fixtures/files/platform_iam_get_permission.json"),
        status: 200,
        headers: { 'Content-Type': 'application/json' }
      )
    end

    def default_params
      { id: '10000000-0000-0000-0000-000000000000', name: 'PolicySpec', description: 'can do anything', inline: false, owner: 'user', statements: [] }
    end

    def expected_attrs
      { id: '10000000-0000-0000-0000-000000000000', name: 'PolicySpec', description: 'can do anything', inline: false, owner: 'user', statements: [] }
    end

    test 'Permission Deny' do
      e = assert_raises InvalidPermissions do
        Operation::Destroy.call(params: { id: policies(:spec).id })
      end
      assert_equal ['Permissions is invalid'], JSON.parse(e.message)
    end

    test 'Destory Data' do
      ctx = Operation::Destroy.call(params: { id: policies(:spec).id }, current_user: @current_user, action: 'DUMMY_ACTION_ID')
      assert ctx.success?
      assert_equal [], ::Policy.where({ id: policies(:spec).id })
    end

    test 'Destroy No Data' do
      e = assert_raises InvalidParameters do
        Operation::Destroy.call(params: { id: -1 }, current_user: @current_user, action: 'DUMMY_ACTION_ID')
      end
      assert_equal ['Parameters is invalid'], JSON.parse(e.message)
    end
  end
end
