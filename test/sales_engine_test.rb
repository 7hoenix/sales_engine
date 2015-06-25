require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  attr_reader :sales_engine

  def setup
    @sales_engine = SalesEngine.new("./test/fixtures")

    sales_engine.startup

    total_merchants = sales_engine.merchant_repository.all
    total_transactions = sales_engine.transaction_repository.all
    total_invoices = sales_engine.invoice_repository.all
    total_invoice_items = sales_engine.invoice_item_repository.all
    total_customers = sales_engine.customer_repository.all
    total_items = sales_engine.item_repository.all
  end

  def test_revenue_method_returns_revenue_for_merchant


    merchant = sales_engine.merchant_repository.find_by_name("Willms and Sons")

    assert_equal "Willms and Sons", merchant.name


    merchant.inspect

    invoices = merchant.invoices

    transactions = invoices.flat_map { |invoice| invoice.transactions }
    good_invoices = transactions.flat_map do |transaction|
      transaction.invoice if transaction.result == "success"
    end
    good_invoice_items = good_invoices.compact.flat_map do |invoice|
      invoice.invoice_items
    end

    revenue = good_invoice_items.flat_map do |ii|
      ii.quantity * ii.unit_price
    end

    assert_equal 6926.29, revenue.reduce(:+)

  end


  def test_it_finds_total_revenue_for_a_merchant_on_a_specific_date

    merchant = sales_engine.merchant_repository.find_by_name("Cummings-Thiel")

    assert_equal "Cummings-Thiel", merchant.name

    date = Date.parse("2012-03-27 11:54:11 UTC")

    invoices = merchant.invoices

    if date == nil
      transactions = invoices.flat_map { |invoice| invoice.transactions }
    else
      transactions = invoices.flat_map { |invoice| invoice.transactions if invoice.created_at == date }
    end
    good_invoices = transactions.compact.flat_map { |transaction| transaction.invoice if transaction.result == "success" }
    good_invoice_items = good_invoices.compact.flat_map { |invoice| invoice.invoice_items }
    revenue = good_invoice_items.flat_map { |invoice_item| invoice_item.quantity * invoice_item.unit_price }

    assert_equal 6300.18, revenue.reduce(:+)

  end

  def test_it_returns_the_customer_who_has_conducted_the_most_successful_transactions

    merchant = sales_engine.merchant_repository.find_by_name("Bernhard-Johns")

    assert_equal "Bernhard-Johns", merchant.name

    invoices = merchant.invoices

    transactions = invoices.flat_map { |invoice| invoice.transactions }

    good_invoices = transactions.compact.flat_map { |transaction| transaction.invoice if transaction.result == "success" }
    good_customers = good_invoices.compact.flat_map { |invoice| invoice.customer }

    customers_grouped = good_customers.group_by { |customer| customer.id }

    best_customer_list = customers_grouped.sort_by { |customer| customer[1].size }

    sales_engine.customer_repository.find_by_id(best_customer_list.last[0])

    assert_equal 19, merchant.favorite_customer.id

  end

end
