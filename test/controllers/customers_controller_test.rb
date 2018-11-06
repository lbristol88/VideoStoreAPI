require 'test_helper'

describe CustomersController do
  CUSTOMER_FIELDS = %w(name registered_at address city state postal_code phone).sort

  def parse_body(expected_type:, expected_status: :success)
    must_respond_with expected_status

    expect(response.header['Content-Type']).must_include 'json'
    body = JSON.parse(response.body)

    expect(body).must_be_kind_of expected_type
    return body
  end

  describe "index" do

    it "successfully gets list of customers" do
      get customers_path

      body = parse_body(expected_type: Array)

      body.each do |customer|
    
        expect(customer.keys.sort).must_equal CUSTOMER_FIELDS
      end
    end

  end



end
