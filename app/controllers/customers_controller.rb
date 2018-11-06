class CustomersController < ApplicationController

  def index
    customers = Customer.all
    render json: jsonify(customers), status: :ok
  end


  # def zomg
  #   render json: { :zomg => "it works"}
  # end

private
  #strong params
  def customer_params
    params.require(:customer).permit(:name, :registered_at, :address, :city, :state, :postal_code, :phone)
  end

  def jsonify(customer_data)
    return customer_data.as_json(only: [:name, :registered_at, :address, :city, :state, :postal_code, :phone])
  end

end
