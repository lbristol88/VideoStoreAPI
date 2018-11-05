require 'test_helper'

describe Rental do
  let (:rental) {
    rentals(:one)
  }

  describe 'relations' do

    it 'has a customer' do
      expect( rental.customer ).must_be_instance_of Customer

    end

    it 'has a movie' do
      expect( rental.movie ).must_be_instance_of Movie

    end

  end

  describe 'validations' do

    it 'is valid when checkout_date is present' do
      expect( rental ).must_be :valid?

    end

    it 'is invalid when checkout_date is missing' do
      rental.checkout_date = nil
      expect( rental ).wont_be :valid?

    end

  end

end
