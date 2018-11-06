require 'test_helper'

describe MoviesController do
  MOVIE_FIELDS = %w(title overview release_date inventory).sort

  def parse_body(expected_type:, expected_status: :success)
    must_respond_with expected_status

    expect(response.header['Content-Type']).must_include 'json'
    body = JSON.parse(response.body)

    expect(body).must_be_kind_of expected_type
    return body
  end

  describe "index" do

    it "successfully gets list of movies" do
      get movies_path

      body = parse_body(expected_type: Array)

      body.each do |movie|
        expect(movie.keys.sort).must_equal MOVIE_FIELDS
      end
    end

    it "returns an empty array when there are no movies" do
      Movie.destroy_all

      get movies_path

      body = parse_body(expected_type: Array)

      expect(body).must_equal []
    end
  end

  describe "show" do
    let (:movie) {
      movies(:titanic)
    }

    it "successfully returns valid movie" do

      get movie_path(movie.id)

      body = parse_body(expected_type: Hash)
      expect(body.keys.sort).must_equal MOVIE_FIELDS
    end

    it 'does not successfully return if invalid movie' do

      movie.destroy

      get movie_path(movie.id)

      body = parse_body(expected_type: Hash, expected_status: :not_found)

      expect(body).must_include "errors"
    end

    describe "create" do

      let (:movie_data) {
        {
          movie: {
            title: "test movie",
            inventory: 10
          }
        }
      }

      it "successfully creates a new movie" do
        expect {
          post movies_path, params: movie_data
        }.must_change('Movie.count', +1)

        body = parse_body(expected_type: Hash)

        expect(body).must_include "id"

        movie = Movie.find(body["id"].to_i)

        expect(movie.title).must_equal movie_data[:movie][:title]


      end

      it 'does not successfully return if invalid' do

        movie_data[:movie][:title] = nil

        expect {
          post movies_path, params: movie_data
        }.wont_change('Movie.count')

        body = parse_body(expected_type: Hash, expected_status: :bad_request)

        expect(body).must_include "errors"
        expect(body["errors"]).must_include "title"

      end

    end
  end
end
