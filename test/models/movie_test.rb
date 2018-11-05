require 'test_helper'

describe Movie do
  let (:movie) {
    movies(:titanic)
  }

  describe 'relations' do
    it 'has some rentals' do
      expect( movie.rentals ).must_respond_to :each

    end

  end

  describe 'validations' do

    it 'is valid when name is present' do

      expect( movie ).must_be :valid?

    end

    it 'is invalid without a name' do

      movie.title = nil

      expect( movie ).wont_be :valid?

    end

    it 'is invalid without inventory' do

      movie.inventory = nil

      expect( movie ).wont_be :valid?
    end

    it 'is invalid if negative inventory' do
      movie.inventory = -1

      expect( movie ).wont_be :valid?
    end

  end


end
