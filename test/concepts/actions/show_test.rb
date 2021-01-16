require 'test_helper'

module Actions
  class ShowTest < ActionDispatch::IntegrationTest
    fixtures :actions

    setup do
      @current_user = JSON.parse({ name: 'Spec' }.to_json, object_class: OpenStruct)
      WebMock.stub_request(:get, %r{#{ENV['HTTP_IAM_URL']}/permissions/}).to_return(
        body: File.read("#{Rails.root}/test/fixtures/files/platform_iam_get_permission.json"),
        status: 200,
        headers: { 'Content-Type': 'application/json' }
      )
    end

    def default_params
      { id: '10000000-0000-0000-0000-000000000000', service_id: actions(:list).service_id, name: 'ActionSpec', description: 'This is Action', access_level: 'list' }
    end

    def expected_attrs
      { id: '10000000-0000-0000-0000-000000000000', service_id: actions(:list).service_id, name: 'ActionSpec', description: 'This is Action', access_level: 'list' }
    end

    test 'Show Data' do
      ctx = Operation::Show.call(params: { id: actions(:list).id }, current_user: @current_user)
      assert_equal actions(:list).name, ctx[:model].name
    end

    test 'Show No Data' do
      e = assert_raises InvalidParameters do
        Operation::Show.call(params: { id: -1 }, current_user: @current_user)
      end
      assert_equal ['Parameters is invalid'], JSON.parse(e.message)
    end
  end
end
