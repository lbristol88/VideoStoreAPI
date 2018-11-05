require 'test_helper'

describe Customer do
  let (:customer) {
    customers(:layla)
  }

  describe 'relations' do
    it 'has some rentals' do
      expect( customer.rentals ).must_respond_to :each

    end

  end

  describe 'validations' do

    it 'is valid when name is present' do

      expect( customer ).must_be :valid?

    end

    it 'is invalid without a name' do

      customer.name = nil

      expect( customer ).wont_be :valid?

    end

  end
end
