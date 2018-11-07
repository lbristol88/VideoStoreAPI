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
    customer_list = customer_data.as_json(only: [:id, :name, :registered_at, :address, :city, :state, :postal_code, :phone], :methods => :movies_checked_out_count)

  #   # customer_list.each do |customer|
  #   #   customer.merge({"movies_checked_out_count": Customer.find_by(id: customer["id"]).movies_checked_out_count})
  #   # end
  #   # return customer_list
  end

end
