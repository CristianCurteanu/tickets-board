# frozen_string_literal: true

require 'rails_helper'

describe Board, type: :model do
  it 'should have one admin' do
    should belong_to(:admin)
  end

  it 'should be able to add users' do
    board = board_generator.call
    user = user_generator.call
    board.add_user user
    expect(board.users.to_a).to eql [user]
  end

  it 'should be able to remove users' do
    board = board_generator.call
    user = user_generator.call
    board.add_user user
    expect(board.users.to_a).to eql [user]
    board.remove_user user
    expect(board.users.to_a).to eql []
  end

  it 'should have name' do
    board = Board.new description: Faker::Company.catch_phrase,
                      background:  Faker::Color.hex_color,
                      admin:       user_generator.call
    expect(board.valid?).to be false
  end

  it 'should have description' do
    board = Board.new name:       Faker::Company.name,
                      background: Faker::Color.hex_color,
                      admin:      user_generator.call
    expect(board.valid?).to be false
  end

  it 'should have default background' do
    board = Board.new description: Faker::Company.catch_phrase,
                      name:        Faker::Company.name,
                      admin:       user_generator.call
    expect(board.valid?).to be true
    expect(board.background).to eql '#eee'
  end
end
