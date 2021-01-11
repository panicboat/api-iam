require 'test_helper'

module Policies
  class CreateTest < ActionDispatch::IntegrationTest
    fixtures :policies

    setup do
      @current_user = JSON.parse({ name: 'Spec' }.to_json, object_class: OpenStruct)
      WebMock.stub_request(:get, "#{ENV['HTTP_IAM_URL']}/permissions/00000000-0000-0000-0000-000000000000").to_return(
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
        Operation::Create.call(params: default_params)
      end
      assert_equal ['Permissions is invalid'], JSON.parse(e.message)
    end

    test 'Create Data' do
      ctx = Operation::Create.call(params: default_params, current_user: @current_user)
      assert ctx.success?
      assert_equal 'PolicySpec', ctx[:model].name
    end

    test 'Create Policy Statements' do
      params = default_params.merge({ statements: [{ effect: 'allow', actions: ['iam:List*'], resources: ['prn:panicboat:platform:iam:service/bc2edb53-551c-4bab-af24-ec1b63b89a3b'] }] })
      result = Operation::Create.call(params: params, current_user: @current_user)
      result[:model].statements do |statement|
        assert_equal statement.effect 'allow'
        assert_equal statement.actions ['iam:List*']
        assert_equal statement.resources ['prn:panicboat:platform:iam:service/bc2edb53-551c-4bab-af24-ec1b63b89a3b']
      end
    end
  end
end
