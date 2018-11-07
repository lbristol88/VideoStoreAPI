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

  describe "movies checked out count" do
    it "returns number of movies checked out" do
      expect(customer.movies_checked_out_count).must_equal 1
    end

    it "increases by one when customer checks out movie" do

      prev_checked = customer.movies_checked_out_count

      Rental.create!(customer_id: customer.id, movie_id: movies(:jaws).id)

      customer.reload

      expect(customer.movies_checked_out_count).must_equal prev_checked + 1
    end

    it "decreases by one when customer checks in a movie" do
      prev_checked = customer.movies_checked_out_count

      rental = Rental.find_by(customer_id: customer.id, movie_id: movies(:titanic).id)
      rental.update(return_date: Time.now)

      customer.reload

      expect(customer.movies_checked_out_count).must_equal prev_checked - 1
    end
  end
end
