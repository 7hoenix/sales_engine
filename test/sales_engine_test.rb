require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_it_exists
    engine = SalesEngine.new

    assert engine
  end

  def test_revenue_method_returns_revenue_for_merchant

    sales_engine = SalesEngine.new("./test/fixtures")

    sales_engine.startup

    total_merchants = sales_engine.merchant_repository.all
    total_transactions = sales_engine.transaction_repository.all
    total_invoices = sales_engine.invoice_repository.all
    total_invoice_items = sales_engine.invoice_item_repository.all
    total_customers = sales_engine.customer_repository.all
    total_items = sales_engine.item_repository.all
    assert_equal 100, total_merchants.count
    assert_equal 99, total_invoices.count
    assert_equal 99, total_invoice_items.count
    assert_equal 99, total_customers.count
    assert_equal 99, total_items.count
    assert_equal 99, total_transactions.count

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

    revenue.reduce(:+)


  end


end
