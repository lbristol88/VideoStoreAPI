class Customer < ApplicationRecord

  has_many :rentals

  validates :name, presence: true

  def movies_checked_out_count
    return self.rentals.count{ |rental| rental.return_date.nil? }
  end

end
