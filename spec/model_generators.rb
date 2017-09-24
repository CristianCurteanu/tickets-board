# frozen_string_literal: true

module ModelGenerators
  def user_generator
    lambda do
      User.create! email:      Faker::Internet.email,
                   first_name: Faker::Name.first_name,
                   last_name:  Faker::Name.last_name,
                   password:   Faker::Internet.password
    end
  end

  def board_generator
    lambda do
      Board.create! name:        Faker::Company.name,
                    description: Faker::Company.catch_phrase,
                    background:  Faker::Color.hex_color,
                    admin:       user_generator.call
    end
  end

  def column_generator
    title = Faker::Hacker.abbreviation
    lambda do
      Column.create! title:        title,
                     status_name:  title.upcase,
                     description:  Faker::Hacker.say_something_smart,
                     order_number: 1,
                     board:        board_generator.call
    end
  end

  def ticket_generator
    lambda do
      Ticket.create! title:       Faker::Hacker.abbreviation,
                     description: Faker::Hacker.say_something_smart,
                     column:      column_generator.call
    end
  end
end
