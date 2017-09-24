# frozen_string_literal: true

require 'rails_helper'

describe Checkpoint, type: :model do
  let(:checkpoint_data) do
    {
      title:       Faker::Hacker.say_something_smart,
      rate_points: rand((0.to_f..5.to_f)).round(1),
      ticket:      ticket_generator.call
    }
  end

  it 'should belong to ticket' do
    should belong_to :ticket
  end

  it 'should have a title' do
    Checkpoint.new(checkpoint_data.except(:title)).should_not be_valid
  end

  it 'should have rate points' do
    Checkpoint.new(checkpoint_data.except(:rate_points)).should_not be_valid
  end
end
