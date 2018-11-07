class Movie < ApplicationRecord

  has_many :rentals

  validates :title, presence: true
  validates :inventory, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def available_inventory
    return 0
  end


end
