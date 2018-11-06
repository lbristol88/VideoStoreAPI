require 'test_helper'

describe RentalsController do

  def parse_body(expected_type:, expected_status: :success)
    must_respond_with expected_status

    expect(response.header['Content-Type']).must_include 'json'
    body = JSON.parse(response.body)

    expect(body).must_be_kind_of expected_type
    return body
  end

  let (:rental_data) {
    {
      rental: {
        movie_id: Movie.first.id,
        customer_id: Customer.first.id
      }
    }
  }

  describe "check out" do
    it "successfully creates new rental" do

      expect{
        post check_out_path, params: rental_data
      }.must_change('Rental.count', +1)

      body = parse_body(expected_type: Hash)

      expect(body).must_include "id"

    end

    it "does not successfully create if invalid" do

      movie = Movie.find_by(id: rental_data[:rental][:movie_id] )
      movie.destroy

      expect{
        post check_out_path, params: rental_data
      }.wont_change('Rental.count')

      body = parse_body(expected_type: Hash, expected_status: :bad_request)

      expect(body).must_include "errors"
    end
  end

  describe "check in" do

    before do
      @rental = rentals(:one)

      @existing_rental = {
        rental: {
          movie_id: @rental.movie.id,
          customer_id: @rental.customer.id
        }
      }
    end
    it "successfully updates rental with return date" do


      expect(@rental.return_date).must_be_nil
      post check_in_path, params: @existing_rental

      body = parse_body(expected_type: Hash)
      expect(body).must_include "id"
      @rental.reload
      expect(@rental.return_date.strftime("%m/%d/%Y")).must_equal Time.now.strftime("%m/%d/%Y")

    end

    it "does not successfully update if invalid" do

      @rental.destroy

      post check_in_path, params: @existing_rental

      body = parse_body(expected_type: Hash, expected_status: :not_found)
      expect(body).must_include "errors"

    end
  end
end
