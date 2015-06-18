require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer_repository'
require_relative '../lib/customer'

class CustomerTest < Minitest::Test

  def test_it_has_a_first_name
    customer_data = {id: 1, first_name: "Justin"}
    customer_repository = "CUSTOMER REPOSITORY"
    customer = Customer.new(customer_data, customer_repository)

    assert_equal "Justin", customer.first_name
  end
end
