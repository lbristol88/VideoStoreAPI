class CustomersController < ApplicationController

  def index
    customers = Customer.all
    render json: jsonify(customers), status: :ok
  end

private
  #strong params
  def customer_params
    params.require(:customer).permit(:name, :registered_at, :address, :city, :state, :postal_code, :phone)
  end

  def jsonify(customer_data)
    customer_list = customer_data.as_json(only: [:id, :name, :registered_at, :address, :city, :state, :postal_code, :phone], :methods => :movies_checked_out_count)

  end

end
