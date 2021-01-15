require 'test_helper'

module Actions
  class IndexTest < ActionDispatch::IntegrationTest
    fixtures :actions

    setup do
      @current_user = JSON.parse({ name: 'Spec' }.to_json, object_class: OpenStruct)
      WebMock.stub_request(:get, "#{ENV['HTTP_IAM_URL']}/permissions/00000000-0000-0000-0000-000000000000").to_return(
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

    test 'Index Data' do
      ctx = Operation::Index.call(params: { service_id: actions(:list).service_id }, current_user: @current_user)
      assert ctx[:model].Actions.present?
      assert_equal ::Action.all.count, ctx[:model].Actions.length
    end

    test 'Index No Data' do
      service_id = actions(:list).service_id
      ::Action.all.each(&:destroy)
      assert_equal [], Operation::Index.call(params: { service_id: service_id }, current_user: @current_user)[:model].Actions
    end
  end
end
