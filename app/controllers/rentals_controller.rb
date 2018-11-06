class RentalsController < ApplicationController

  #creating a rental
  def check_out
    rental = Rental.new(rental_params)
    rental.update(checkout_date: Time.now.strftime("%Y/%m/%d"), due_date: Time.now + (60 * 60 * 24 * 7))

    if rental.save
      render json: { id: rental.id }, status: :ok
    else
      render_error(:bad_request, rental.errors.messages)
    end
  end

  def check_in
  end

private
#strong params
  def rental_params
    params.require(:rental).permit(:movie_id, :customer_id)
  end

  def jsonify(rental_data)
    return rental_data.as_json(only: [:checkout_date, :due_date, :movie_id, :customer_id])
  end

end
