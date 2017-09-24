require 'rails_helper'

describe Ticket, type: :model do
  it 'should belong to a column' do
    should belong_to(:column)
  end

  let(:ticket_data) do
    {
      title: Faker::Hacker.abbreviation,
      description: Faker::Hacker.say_something_smart,
      column: column_generator.call
    }
  end

  it 'should have many checkpoints' do
    should have_many :checkpoints
  end

  it 'should have many comments' do
    should have_many :comments
  end

  it 'should have title' do
    Ticket.new(ticket_data.except(:title)).should_not be_valid
  end

  it 'should have description' do
    Ticket.new(ticket_data.except(:description)).should_not be_valid
  end

  it 'should have a default order number' do
    ticket = Ticket.new(ticket_data)
    expect(ticket.order_number).to eql 1
  end

  it 'should be able to change the order number with other ticket' do
    ticket = Ticket.create!(ticket_data)
    new_ticket = Ticket.create!(ticket_data)
    expect(ticket.order_number).to eql 1
    expect(new_ticket.order_number).to eql 2

    new_ticket.change_order(ticket)
    expect(ticket.order_number).to eql 2
    expect(new_ticket.order_number).to eql 1
  end
end
