class CustomersController < ApplicationController

  def index
  end
  
  def zomg
    render json: { :zomg => "it works"}
  end

end
