class Movie < ApplicationRecord

  has_many :rentals

  validates :title, presence: true
  validates :inventory, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def available_inventory
    return self.inventory - self.rentals.count{ |rental| rental.return_date.nil? }
  end
end
