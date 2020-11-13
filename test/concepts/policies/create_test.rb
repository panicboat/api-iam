require 'test_helper'

module Policies
  class CreateTest < ActionDispatch::IntegrationTest
    def default_params
      { name: 'Administrators', description: 'can do anything', inline: false, owner: 'user', statements: [] }
    end

    def expected_attrs
      { name: 'Administrators', description: 'can do anything', inline: false, owner: 'user', statements: [] }
    end

    test 'Create Data' do
      result = Operation::Create.call(params: default_params)
      assert_equal result[:model].name,   'Administrators'
      assert_equal result[:model].inline, false
      assert_equal result[:model].owner,  'user'
    end

    test 'Create Policy Statements' do
      params = default_params.merge({ statements: [effect: 'allow', actions: ['iam:List*'], resources: ['prn:panicboat:platform:iam:service/bc2edb53-551c-4bab-af24-ec1b63b89a3b']] })
      result = Operation::Create.call(params: params)
      result[:model].statements do |statement|
        assert_equal statement.effect 'allow'
        assert_equal statement.actions ['iam:List*']
        assert_equal statement.resources ['prn:panicboat:platform:iam:service/bc2edb53-551c-4bab-af24-ec1b63b89a3b']
      end
    end
  end
end
