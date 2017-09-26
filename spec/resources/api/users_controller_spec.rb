# frozen_string_literal: true

require 'rails_helper'

describe 'User resource', type: :request do
  describe 'GET #show' do
    it 'should return a valid user' do
      get '/api/user', headers: { Accept:        'application/json',
                                  Authorization: mock_session }
      expect_status 200
      expect_json_keys :email, :first_name, :last_name
    end
  end

  describe 'GET #create' do
    it 'should register new client' do
      password = JWT.encode({ data: Faker::Internet.password }, ENV['PUBLIC_KEY'])
      post '/api/registration', params: { email:      Faker::Internet.email,
                                          token:      password,
                                          first_name: Faker::Name.first_name,
                                          last_name:  Faker::Name.last_name }
      expect_status 201
    end

    it 'should not be able to register without token' do
      post '/api/registration', params: { email:      Faker::Internet.email,
                                          token:      nil,
                                          first_name: Faker::Name.first_name,
                                          last_name:  Faker::Name.last_name }
      expect_status 400
    end

    it 'should not be able to register without email' do
      password = JWT.encode({ data: Faker::Internet.password }, ENV['PUBLIC_KEY'])
      post '/api/registration', params: { email:      nil,
                                          token:      password,
                                          first_name: Faker::Name.first_name,
                                          last_name:  Faker::Name.last_name }
      expect_status 400
    end

    it 'should not be able to register without first name' do
      password = JWT.encode({ data: Faker::Internet.password }, ENV['PUBLIC_KEY'])
      post '/api/registration', params: { email:      Faker::Internet.email,
                                          token:      password,
                                          first_name: nil,
                                          last_name:  Faker::Name.last_name }
      expect_status 400
    end
  end
end
