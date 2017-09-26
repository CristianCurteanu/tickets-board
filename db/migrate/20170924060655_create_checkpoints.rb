# frozen_string_literal: true

class CreateCheckpoints < ActiveRecord::Migration[5.0]
  def change
    create_table :checkpoints do |t|
      t.references :ticket, foreign_key: true
      t.string :title
      t.decimal :rate_points
    end
  end
end
