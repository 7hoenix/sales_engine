require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test

  def test_it_has_a_merchant_id
      invoice_data = {id: 1, merchant_id: 5}
      invoice_repository = "INVOICE REPOSITORY"
      invoice = Invoice.new(invoice_data, invoice_repository)

      assert_equal 5, invoice.merchant_id
  end
end
