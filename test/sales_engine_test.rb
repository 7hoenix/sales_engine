require 'simplecov'
SimpleCov.start

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

  def test_it_parses_merchant_data
    merchant = engine.parse_merchant_data
    assert_equal [["1", "Schroeder-Jerde", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["2", "Klein, Rempel and Jones", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["3", "Willms and Sons", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["4", "Cummings-Thiel", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["5", "Williamson Group", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["6", "Williamson Group", "2012-03-27 14:53:59 UTC", "2012-03-27 16:12:25 UTC"], ["7", "Bernhard-Johns", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["8", "Osinski, Pollich and Koelpin", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["9", "Hand-Spencer", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["10", "Bechtelar, Jones and Stokes", "2012-03-27 14:54:00 UTC", "2012-03-27 14:54:00 UTC"]], merchant
  end

  def test_it_parses_customer_data
    merchant = engine.parse_merchant_data
    assert_equal [["1", "Schroeder-Jerde", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["2", "Klein, Rempel and Jones", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["3", "Willms and Sons", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["4", "Cummings-Thiel", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["5", "Williamson Group", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["6", "Williamson Group", "2012-03-27 14:53:59 UTC", "2012-03-27 16:12:25 UTC"], ["7", "Bernhard-Johns", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["8", "Osinski, Pollich and Koelpin", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["9", "Hand-Spencer", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["10", "Bechtelar, Jones and Stokes", "2012-03-27 14:54:00 UTC", "2012-03-27 14:54:00 UTC"]], merchant
  end

  # def test_it_parses_invoice_item_data
  #   merchant = engine.parse_merchant_data
  #   assert_equal [["1", "Schroeder-Jerde", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["2", "Klein, Rempel and Jones", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["3", "Willms and Sons", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["4", "Cummings-Thiel", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["5", "Williamson Group", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["6", "Williamson Group", "2012-03-27 14:53:59 UTC", "2012-03-27 16:12:25 UTC"], ["7", "Bernhard-Johns", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["8", "Osinski, Pollich and Koelpin", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["9", "Hand-Spencer", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["10", "Bechtelar, Jones and Stokes", "2012-03-27 14:54:00 UTC", "2012-03-27 14:54:00 UTC"]], merchant
  # end
  #
  # def test_it_parses_invoice_data
  #   merchant = engine.parse_merchant_data
  #   assert_equal [["1", "Schroeder-Jerde", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["2", "Klein, Rempel and Jones", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["3", "Willms and Sons", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["4", "Cummings-Thiel", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["5", "Williamson Group", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["6", "Williamson Group", "2012-03-27 14:53:59 UTC", "2012-03-27 16:12:25 UTC"], ["7", "Bernhard-Johns", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["8", "Osinski, Pollich and Koelpin", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["9", "Hand-Spencer", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["10", "Bechtelar, Jones and Stokes", "2012-03-27 14:54:00 UTC", "2012-03-27 14:54:00 UTC"]], merchant
  # end
  #
  # def test_it_parses_item_data
  #   merchant = engine.parse_merchant_data
  #   assert_equal [["1", "Schroeder-Jerde", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["2", "Klein, Rempel and Jones", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["3", "Willms and Sons", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["4", "Cummings-Thiel", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["5", "Williamson Group", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["6", "Williamson Group", "2012-03-27 14:53:59 UTC", "2012-03-27 16:12:25 UTC"], ["7", "Bernhard-Johns", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["8", "Osinski, Pollich and Koelpin", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["9", "Hand-Spencer", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["10", "Bechtelar, Jones and Stokes", "2012-03-27 14:54:00 UTC", "2012-03-27 14:54:00 UTC"]], merchant
  # end
  #
  # def test_it_parses_transaction_data
  #   merchant = engine.parse_merchant_data
  #   assert_equal [["1", "Schroeder-Jerde", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["2", "Klein, Rempel and Jones", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["3", "Willms and Sons", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["4", "Cummings-Thiel", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["5", "Williamson Group", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["6", "Williamson Group", "2012-03-27 14:53:59 UTC", "2012-03-27 16:12:25 UTC"], ["7", "Bernhard-Johns", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["8", "Osinski, Pollich and Koelpin", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["9", "Hand-Spencer", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["10", "Bechtelar, Jones and Stokes", "2012-03-27 14:54:00 UTC", "2012-03-27 14:54:00 UTC"]], merchant
  # end


  def test_it_loads_data_from_the_csv
    skip
    assert_kind_of CSV, engine.parse_merchant_data
  end

  def test_the_parser_sanitizes_merchant_data
    skip
    sanitized = engine.parse_merchant_data

    assert_equal "", sanitized
  end

  def test_it_starts_up
    skip
    engine.startup
  end

  def test_it_loads_merchant_data
    skip
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
