# frozen_string_literal: true

require 'rails_helper'

describe Column, type: :model do
  before(:all) do
    @board = board_generator.call
  end

  let(:column_data) do
    {
      title:        'Open',
      status_name:  'OPEN',
      description:  'Task are open to get them done',
      order_number: 1,
      board:        @board
    }
  end

  it 'should belong to a board' do
    should belong_to :board
  end

  it 'should have many tickets' do
    should have_many :tickets
  end

  it 'should have a title' do
    Column.new(column_data.except(:title)).should_not be_valid
  end

  it 'should have status name' do
    Column.new(column_data.except(:status_name)).should_not be_valid
  end

  it 'should have description' do
    Column.new(column_data.except(:description)).should_not be_valid
  end

  it 'should have a order number' do
    column = Column.new(column_data.except(:order_number))
    column.should be_valid
    expect(column.order_number).to eql 1
  end

  it 'should be able to change order number with other columns in a board' do
    first_column = Column.create!(column_data)
    second_column = Column.create!(column_data.merge(order_number: 3))
    first_column.change_order second_column
    expect(first_column.order_number).to eql 3
    expect(second_column.order_number).to eql 1
  end

  it 'should receive last order in the board number when created' do
    first_column = Column.create!(column_data)
    second_column = Column.create!(column_data.merge(order_number: 2))
    last_column = Column.new(column_data.except(:order_number))
    last_column.save!

    expect(first_column.order_number).to eql 1
    expect(second_column.order_number).to eql 2
    expect(last_column.order_number).to eql 3
  end
end
