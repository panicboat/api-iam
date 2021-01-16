require 'test_helper'

module Services
  class ShowTest < ActionDispatch::IntegrationTest
    fixtures :services

    setup do
      @current_user = JSON.parse({ name: 'Spec' }.to_json, object_class: OpenStruct)
      WebMock.stub_request(:get, %r{#{ENV['HTTP_IAM_URL']}/permissions/}).to_return(
        body: File.read("#{Rails.root}/test/fixtures/files/platform_iam_get_permission.json"),
        status: 200,
        headers: { 'Content-Type': 'application/json' }
      )
    end

    def default_params
      { id: '10000000-0000-0000-0000-000000000000', name: 'Service', description: 'This is description' }
    end

    def expected_attrs
      { id: '10000000-0000-0000-0000-000000000000', name: 'Service', description: 'This is description' }
    end

    test 'Show Data' do
      ctx = Operation::Show.call(params: { id: services(:spec).id }, current_user: @current_user)
      assert_equal services(:spec).name, ctx[:model].name
    end

    test 'Show No Data' do
      e = assert_raises InvalidParameters do
        Operation::Show.call(params: { id: -1 }, current_user: @current_user)
      end
      assert_equal ['Parameters is invalid'], JSON.parse(e.message)
    end
  end
end
