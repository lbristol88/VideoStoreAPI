class MoviesController < ApplicationController

  def index
    movies = Movie.all
    render json: jsonify(movies), status: :ok
  end

  def show
    movie_id = params[:id]
    movie = Movie.find_by(id: movie_id)
    if pet
      render json: movie.as_json(only: [:title, :overview, :release_date]), status: :ok
    else
      render_error(:not_found, {movie_id: ["Movie does not exist."]})
    end
  end

  def create
    movie = Movie.new(movie_params)
    if movie.save
      render json: { id: movie.id }, status: :ok
    else
      render_error(:bad_request, movie.errors.messages)
    end
  end

private
  #strong params
  def movie_params
    params.require(:movie).permit(:title, :overview, :release_date, :inventory)
  end

  def jsonify(movie_data)
    return movie_data.as_json(only: [:title, :overview, :release_date, :inventory]), status: :ok
  end

end
