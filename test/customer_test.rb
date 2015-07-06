require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
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

  def test_it_returns_an_array_of_transaction_instances_associated_with_the_customer
    sales_engine = SalesEngine.new

    customer_repository = sales_engine.create_customer_repository([
                                                                      {id: 1},
                                                                      {id: 2},
                                                                      {id: 3},
                                                                  ])
    sales_engine.create_invoice_repository([
                                               {id: 10, customer_id: 1},
                                               {id: 11, customer_id: 1},
                                               {id: 20, customer_id: 2},
                                               {id: 30, customer_id: 3},
                                           ])
    sales_engine.create_transaction_repository([
                                                   {id: 100, invoice_id: 10},
                                                   {id: 101, invoice_id: 10},
                                                   {id: 102, invoice_id: 11},
                                                   {id: 200, invoice_id: 20},
                                                   {id: 300, invoice_id: 30},
                                               ])

    customer = customer_repository.find_by_id(1)
    transactions = customer.transactions
    assert_equal [100, 101, 102], transactions.map { |transaction| transaction.id }
  end

  def test_it_returns_an_instance_of_merchant_where_the_customer_has_conducted_the_most_successful_transactions
    sales_engine = SalesEngine.new

    customer_repository = sales_engine.create_customer_repository([
                                                                      {id: 1},
                                                                      {id: 2},
                                                                  ])
    sales_engine.create_invoice_repository([
                                               {id: 101, customer_id: 1, merchant_id: 10},
                                               {id: 102, customer_id: 2, merchant_id: 10},
                                               {id: 103, customer_id: 1, merchant_id: 11},
                                               {id: 104, customer_id: 1, merchant_id: 11},
                                               {id: 105, customer_id: 1, merchant_id: 12},
                                           ])
    sales_engine.create_transaction_repository([
                                                   {id: 1001, invoice_id: 101, result: "success"},
                                                   {id: 1002, invoice_id: 101, result: "success"},
                                                   {id: 1003, invoice_id: 102, result: "failed"},
                                                   {id: 1004, invoice_id: 102, result: "success"},
                                                   {id: 1005, invoice_id: 103, result: "failed"},
                                                   {id: 1006, invoice_id: 103, result: "success"},
                                               ])
    sales_engine.create_merchant_repository([
                                                {id: 10},
                                                {id: 11},
                                                {id: 12},
                                            ])
    current_customer = customer_repository.find_by_id(1)
    favorite_merchant = current_customer.favorite_merchant
    assert_equal 10, favorite_merchant.id
  end
end
