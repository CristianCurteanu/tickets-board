class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.belongs_to :column, index: true
      t.string :title
      t.text :description
      t.integer :order_number

      t.timestamps
    end
  end
end
