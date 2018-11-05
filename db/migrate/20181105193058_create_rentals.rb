class CreateRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :rentals do |t|

      t.date :checkout_date
      t.date :due_date

      t.belongs_to :movie, index: true
      t.belongs_to :customer, index: true
      t.timestamps
    end
  end
end
