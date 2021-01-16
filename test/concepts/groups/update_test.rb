require 'test_helper'

module Groups
  class UpdateTest < ActionDispatch::IntegrationTest
    fixtures :groups

    setup do
      @current_user = JSON.parse({ name: 'Spec' }.to_json, object_class: OpenStruct)
      WebMock.stub_request(:get, %r{#{ENV['HTTP_IAM_URL']}/permissions/}).to_return(
        body: File.read("#{Rails.root}/test/fixtures/files/platform_iam_get_permission.json"),
        status: 200,
        headers: { 'Content-Type': 'application/json' }
      )
    end

    def default_params
      { id: '10000000-0000-0000-0000-000000000000', name: 'GroupSpec', description: 'can do anything' }
    end

    def expected_attrs
      { id: '10000000-0000-0000-0000-000000000000', name: 'GroupSpec', description: 'can do anything' }
    end

    test 'Permission Deny : No Session' do
      e = assert_raises InvalidPermissions do
        Operation::Update.call(params: { id: groups(:spec).id, name: 'This is name.' })
      end
      assert_equal ['Permissions is invalid'], JSON.parse(e.message)
    end

    test 'Update Data' do
      ctx = Operation::Update.call(params: { id: groups(:spec).id, name: 'This is name.' }, current_user: @current_user)
      assert ctx.success?
      assert_equal 'This is name.', ctx[:model].name
    end

    test 'Update No Data' do
      e = assert_raises InvalidParameters do
        Operation::Update.call(params: { id: -1 })
      end
      assert_equal ['Parameters is invalid'], JSON.parse(e.message)
    end
  end
end
