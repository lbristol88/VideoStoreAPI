require 'test_helper'

class MoviesControllerTest < ActionDispatch::IntegrationTest

  describe "index" do

    it "successfully gets list of movies" do
      get movies_path
      must_respond_with :success
    end

  end

  describe "show" do
    let (:movie) {
      movies(:titanic)
    }

    it "successfully returns valid movie" do

      get movie_path(movie.id)
      must_respond_with :success
    end

    it 'does not successfully return if invalid movie'
      movie.destroy

      get movie_path(movie.id)
      must_respond_with :not_found
    end

  describe "create" do

    it "successfully creates a new movie" do

      

    end

    it 'does not successfully return if invalid'

end
