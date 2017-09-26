# frozen_string_literal: true

class CreateColumns < ActiveRecord::Migration[5.0]
  def change
    create_table :columns do |t|
      t.belongs_to :board, index: true
      t.string :status_name
      t.string :title
      t.text :description
      t.integer :order_number
    end
  end
end
