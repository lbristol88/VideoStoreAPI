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

  describe "available inventory" do

    it 'successfully returns available inventory of a movie' do
      expect(movie.available_inventory).must_equal 9
    end

    it 'decreases when a customer has checked out a movie' do

      prev_inventory = movie.available_inventory


      Rental.create!(movie_id: movie.id, customer_id: customers(:aurea).id)

      movie.reload
      expect(movie.available_inventory).must_equal prev_inventory - 1
    end

    it 'increases when a customer has checked in a movie' do

      prev_inventory = movie.available_inventory

      rental = Rental.find_by(movie_id: movie.id, customer_id: customers(:layla).id)

      rental.update(return_date: Time.now )

      movie.reload

      expect(movie.available_inventory).must_equal prev_inventory + 1
    end
  end


end
