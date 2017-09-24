# frozen_string_literal: true

class CreateBoards < ActiveRecord::Migration[5.0]
  def change
    create_table :boards do |t|
      t.belongs_to :admin
      t.integer :user_ids, array: true, default: []
      t.string  :background
      t.string  :name
      t.text    :description

      t.timestamps
    end
  end
end
