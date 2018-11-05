require 'test_helper'

class CustomersControllerTest < ActionDispatch::IntegrationTest

  describe "index" do

    it "successfully gets list of customers" do
      get customers_path
      must_respond_with :success
    end

  end



end
