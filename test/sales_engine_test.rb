require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  attr_reader :engine

  def setup
    @engine = SalesEngine.new
  end

  def test_it_exists
    assert engine
  end

  def test_it_starts_up
    skip
    engine.startup
  end

  def test_it_loads_merchant_data
    engine.merchant_repository
  end

  def test_it_loads_invoice_data
    skip
    engine.invoice_repository
  end

  def test_it_loads_item_data
    skip
    engine.item_repository
  end

  def test_it_loads_invoice_item_data
    skip
    engine.invoice_item_repository
  end

  def test_it_loads_customer_data
    skip
    engine.customer_repository
  end

  def test_it_loads_transaction_data
    skip
    engine.transaction_repository
  end

end