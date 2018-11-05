class Rental < ApplicationRecord

  belongs_to :customer
  belongs_to :movie

  validates :checkout_date, presence: true
end
