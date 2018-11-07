class MoviesController < ApplicationController

  def index
    movies = Movie.all
    render json: jsonify(movies), status: :ok
  end

  def show
    movie_id = params[:id]
    movie = Movie.find_by(id: movie_id)

    if movie
      render json: jsonify(movie)
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
    params.permit(:title, :overview, :release_date, :inventory)
  end

  def jsonify(movie_data)
    movie_list = movie_data.as_json(only: [:id, :title, :overview, :release_date, :inventory], :methods => :available_inventory)

  end

end
