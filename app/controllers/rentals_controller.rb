class RentalsController < ApplicationController

  # creating a rental
  def check_out

    rental = Rental.new(rental_params)
    rental.due_date = (Time.now + (60 * 60 * 24 * 7))

    if rental.save
      render json: { id: rental.id }, status: :ok
    else
      render_error(:bad_request, rental.errors.messages)
    end
  end

  # returning a rental
  def check_in
    rental = Rental.find_by(rental_params)

    if rental
      rental.update(return_date: Time.now )
      render json: { id: rental.id }, status: :ok
    else
      render_error(:not_found, { rental_id: ["rental not found"] })
    end
  end


  private
  #strong params
  def rental_params
    params.permit(:movie_id, :customer_id)

  end

  def jsonify(rental_data)
    return rental_data.as_json(only: [:return_date, :due_date, :movie_id, :customer_id])
  end

end
