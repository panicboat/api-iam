require 'test_helper'

module Policies
  class IndexTest < ActionDispatch::IntegrationTest
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

    test 'Index Data' do
      ctx = Operation::Index.call(params: {}, current_user: @current_user, action: 'DUMMY_ACTION_ID')
      assert ctx[:model].Policies.present?
      assert_equal ::Policy.all.count, ctx[:model].Policies.length
    end

    test 'Index No Data' do
      ::Policy.all.each(&:destroy)
      assert_equal [], Operation::Index.call(params: {}, current_user: @current_user, action: 'DUMMY_ACTION_ID')[:model].Policies
    end
  end
end
