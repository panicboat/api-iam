require 'test_helper'

class TokenManagerTest < ActionDispatch::IntegrationTest
  setup do
    WebMock.stub_request(:get, "https://cognito-idp.#{ENV['AWS_DEFAULT_REGION']}.amazonaws.com/.well-known/").to_return(
      body: File.read("#{Rails.root}/test/fixtures/files/aws_cognito_jwks.json"),
      status: 200,
      headers: { "Content-Type": 'application/json' }
    )
  end
end
