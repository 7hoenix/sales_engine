require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test
  def test_it_has_a_item_id
    invoice_item_data = {id: 1, item_id: 5}
    invoice_item_repository = "INVOICE ITEM REPOSITORY"
    invoice_item = InvoiceItem.new(invoice_item_data, invoice_item_repository)

    assert_equal 5, invoice_item.item_id
  end
end
