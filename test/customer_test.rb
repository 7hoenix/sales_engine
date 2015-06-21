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

  def test_it_finds_a_collection_of_invoices_associated_with_a_customer
    sales_engine = SalesEngine.new

    customer_repository = CustomerRepository.new([
                                                     {id: 4},
                                                     {id: 2},
                                                     {id: 3},
                                                 ], sales_engine)

    sales_engine.create_invoice_repository([{id: 15, customer_id: 4},
                                           {id: 30, customer_id: 2},
                                           {id: 45, customer_id: 3},
                                           {id: 60, customer_id: 4}])

    customer = Customer.new({id: 4}, customer_repository)

    invoices = customer.invoices

    assert_equal [15, 60], invoices.map { |invoice| invoice.id}
  end
end
