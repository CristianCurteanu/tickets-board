# frozen_string_literal: true

require 'rails_helper'

describe 'Boards resource', type: :request do
  describe 'GET #all' do
    it 'returns if user is authorized' do
      board = board_generator.call
      token = mock_session board.admin
      get '/api/user/boards', headers: { Accept:        'application/json',
                                         Authorization: token }
      expect_status 200
    end

    it 'return 401 is client is not authorized' do
      get '/api/user/boards', headers: { Accept:        'application/json',
                                         Authorization: nil }
      expect_status 401
    end
  end

  describe 'GET #show' do
    it 'should be able to get a board by id if authenticated' do
      board = board_generator.call
      token = mock_session board.admin
      get "/api/board/#{board.id}", headers: { Accept: 'application/json',
                                               Authorization: token }
      expect_status 200
      expect_json_keys :id, :name, :description, :background
    end
  end

  describe 'POST #create' do
    it 'should be able to create a new board' do
      post '/api/board', params: { name: 'Some project',
                                   description: 'Random description for a project' },
                         headers: { Accept: 'application/json',
                                    Authorization: mock_session }
      expect_status 201
    end
  end

  describe 'PUT #update' do
    it 'should be able to update board if user authenticated' do
      board = board_generator.call
      token = mock_session board.admin
      put "/api/board/#{board.id}", params: { name: 'Other project name' },
                                    headers: { Accept: 'application/json',
                                               Authorization: token }
      expect_status 200
    end
  end

  describe 'PUT #add_user' do
    it 'should be able to add user to a board' do
      board = board_generator.call
      token = mock_session board.admin
      user = user_generator.call
      put "/api/board/#{board.id}/user", params: { user_id: user.id },
                                         headers: { Accept: 'application/json',
                                                    Authorization: token }
      expect_status 200
    end

    it 'should return error if no user ID specified' do
      board = board_generator.call
      token = mock_session board.admin
      user = user_generator.call
      put "/api/board/#{board.id}/user", params: { user_id: nil },
                                         headers: { Accept: 'application/json',
                                                    Authorization: token }
      expect_status 400
      expect_json_keys :message
    end

    it 'should return 404 if no such user found' do
      board = board_generator.call
      token = mock_session board.admin
      user = user_generator.call
      put "/api/board/#{board.id}/user", params: { user_id: user.id + 1 },
                                         headers: { Accept: 'application/json',
                                                    Authorization: token }
      expect_status 404
      expect_json_keys :message
    end
  end

  describe 'DELETE #remove_user' do
    it 'should be able to remove user by admin' do
      board = board_generator.call
      token = mock_session board.admin
      user = user_generator.call
      put "/api/board/#{board.id}/user", params: { user_id: user.id },
                                         headers: { Accept: 'application/json',
                                                    Authorization: token }
      expect_status 200
      delete "/api/board/#{board.id}/user", params: { user_id: user.id },
                                            headers: { Accept: 'application/json',
                                                       Authorization: token }
      expect_status 201
    end

    it 'should return 400 if no user ID specified' do
      board = board_generator.call
      token = mock_session board.admin
      user = user_generator.call
      put "/api/board/#{board.id}/user", params: { user_id: user.id },
                                         headers: { Accept: 'application/json',
                                                    Authorization: token }
      expect_status 200
      delete "/api/board/#{board.id}/user", params: { user_id: nil },
                                            headers: { Accept: 'application/json',
                                                       Authorization: token }
      expect_status 400
    end
  end
end
