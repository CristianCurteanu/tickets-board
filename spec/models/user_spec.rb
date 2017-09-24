# frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do
  let(:user_datas) do
    password = Faker::Internet.password(8)
    {
      email:                 Faker::Internet.email,
      first_name:            Faker::Name.first_name,
      last_name:             Faker::Name.last_name,
      password:              password,
      password_confirmation: password
    }
  end

  it 'should have many boards' do
    should have_many :boards
  end

  it 'should have email' do
    User.new(email: nil).should_not be_valid
  end

  it 'should not be valid without a password' do
    user = User.new user_datas.slice(:email, :first_name, :last_name)
    user.should_not be_valid
  end

  it 'should be valid with password confirmation' do
    user = User.new user_datas.merge password: 'short', password_confirmation: 'short'
    user.should be_valid
  end

  it 'should not be valid with a confirmation mismatch' do
    user = User.new user_datas.merge password: 'short', password_confirmation: 'long'
    user.should_not be_valid
  end

  it 'should have first name' do
    User.new(user_datas.except(:first_name)).should_not be_valid
  end

  it 'should have last name' do
    User.new(user_datas.except(:last_name)).should_not be_valid
  end

  it 'should have a right email format' do
    ['random.text@', '@google.com'].each do |email|
      expect(User.new(email: email)).not_to be_valid
    end
  end
end
