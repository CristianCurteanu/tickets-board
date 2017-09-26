# frozen_string_literal: true

module UserMockHelper
  def mock_session(user = nil)
    user = user || create_mock_user
    key = ENV['PUBLIC_KEY']
    post '/api/session', params:  { email: user.email,
                                    token: JWT.encode({ data: user.password }, key) },
                         headers: { Accept: 'application/json',
                                    Cookie: "public_key=#{key}" }
    expect_status 200
    expect_json_keys :token
    JSON.parse(response.body)['token']
  end

  def create_mock_user
    user_generator.call
    # { user: user, password: user.password }
  end
end
