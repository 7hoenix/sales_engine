require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test
  def test_it_has_a_item_id
    invoice_item_data = {id: 1, item_id: 5}
    invoice_item_repository = "INVOICE ITEM REPOSITORY"
    invoice_item = InvoiceItem.new(invoice_item_data, invoice_item_repository)

    assert_equal 5, invoice_item.item_id
  end


  def test_it_find_the_invoice_associated_with_the_invoice_item
    sales_engine = SalesEngine.new
    invoice_item_data = [{id: 1, invoice_id: 15},
                         {id: 2, invoice_id: 30},
                         {id: 3, invoice_id: 45},]

    invoice_item_repository = InvoiceItemRepository.new(invoice_item_data, sales_engine)

    sales_engine.create_invoice_repository([
                                               {id: 15},
                                               {id: 30},
                                               {id: 45},
                                               {id: 60},
                                           ])

    invoice_item = InvoiceItem.new({id: 4, invoice_id: 60}, invoice_item_repository)

    invoice = invoice_item.invoice
    assert_equal 60, invoice.id
  end

  def test_it_finds_the_item_associated_with_the_invoice_item
    sales_engine = SalesEngine.new
    invoice_item_data = [{id: 1, item_id: 15},
                        {id: 2, item_id: 30},
                        {id: 3, item_id: 45},]

    invoice_item_repository = InvoiceItemRepository.new(invoice_item_data, sales_engine)

    sales_engine.create_item_repository([
                                            {id: 15},
                                            {id: 30},
                                            {id: 45},
                                            {id: 60},
                                        ])

    invoice_item = InvoiceItem.new({id: 4, item_id: 60}, invoice_item_repository)

    item = invoice_item.item
    assert_equal 60, item.id
  end

end
