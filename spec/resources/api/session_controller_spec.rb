# frozen_string_literal: true

require 'rails_helper'

describe 'Session resource', type: :request do
  describe 'Authenticate for a session' do
    it 'should create a session with Authorization header' do
      get '/api/user', headers: { Accept:        'application/json',
                                  Authorization: mock_session }
      expect_status 200
    end
  end

  describe 'Destroy session' do
    it 'should destroy session via Authorization header' do
      session_token = mock_session
      get '/api/user', headers: { Accept:        'application/json',
                                  Authorization: session_token }
      expect_status 200
      delete '/api/session', headers: { Accept:        'application/json',
                                        Authorization: session_token }
      get '/api/user', headers: { Accept:        'application/json',
                                  Authorization: session_token }
      expect_status 401
    end
  end
end
