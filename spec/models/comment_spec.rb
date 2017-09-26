# frozen_string_literal: true

require 'rails_helper'

describe Comment, type: :model do
  it 'should belong to a ticket' do
    should belong_to :ticket
  end

  it 'should belong to a user' do
    should belong_to :user
  end

  it 'should have text' do
    comment = Comment.new(user:   user_generator.call,
                          ticket: ticket_generator.call)
    expect(comment).not_to be_valid
  end
end
