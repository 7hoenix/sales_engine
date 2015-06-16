require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test
  attr_reader :invoice

  def setup
    @invoice = Invoice.new(1, 1, 26, "shipped", "2012-03-25 09:54:09 UTC", "2012-03-25 09:54:09 UTC")
  end

  def test_it_exists
    assert Invoice.new(1, 1, 26, "shipped", "2012-03-25 09:54:09 UTC", "2012-03-25 09:54:09 UTC")
  end

  def test_it_has_an_id
    assert_equal 1, invoice.id
  end

  def test_it_has_a_customer_id
    assert_equal 1, invoice.customer_id
  end

  def test_it_has_a_merchant_id
    assert_equal 26, invoice.merchant_id
  end

  def test_it_has_a_status
    assert_equal "shipped", invoice.status
  end

  def test_it_has_a_created_at_time
    assert_equal "2012-03-25 09:54:09 UTC", invoice.created_at
  end

  def test_it_has_an_updated_at_time
    assert_equal "2012-03-25 09:54:09 UTC", invoice.updated_at
  end

end