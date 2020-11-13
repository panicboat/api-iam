require 'test_helper'

module Policies
  class UpdateTest < ActionDispatch::IntegrationTest
    def default_params
      { name: 'Administrators', description: 'can do anything', inline: false, owner: 'user', statements: [] }
    end

    def expected_attrs
      { name: 'Administrators', description: 'can do anything', inline: false, owner: 'user', statements: [] }
    end

    test 'Update Policy' do
      result = Operation::Create.call(params: default_params)
      assert_pass Operation::Update, params({ id: result[:model].id, name: 'This is description.' }), name: 'This is description.'
    end

    test 'Update Policy Statements' do
      params1 = default_params.merge({ statements: [effect: 'allow', actions: ['*'], resources: ['*']] })
      create = Operation::Create.call(params: params1)
      params2 = default_params.merge({ id: create[:model].id, statements: [effect: 'allow', actions: ['iam:List*'], resources: ['prn:panicboat:platform:iam:service/bc2edb53-551c-4bab-af24-ec1b63b89a3b']] })
      result = Operation::Update.call(params: params2)
      result[:model].statements do |statement|
        assert_equal statement.effect 'allow'
        assert_equal statement.actions ['iam:List*']
        assert_equal statement.resources ['prn:panicboat:platform:iam:service/bc2edb53-551c-4bab-af24-ec1b63b89a3b']
      end
    end

    test 'Show No Data' do
      e = assert_raises InvalidParameters do
        Operation::Update.call(params: { id: '12345678-1234-1234-1234-123456789012' })
      end
      assert_equal ['Parameters is invalid'], JSON.parse(e.message)
    end
  end
end
