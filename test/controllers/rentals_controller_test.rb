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
end
