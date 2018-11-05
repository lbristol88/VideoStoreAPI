require 'test_helper'

class CustomersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  describe "index" do
  # These tests are a little verbose - yours do not need to be
  # this explicit.

    it "successfully gets index page" do
      get customers_path
      must_respond_with :success
    end

  end



end
