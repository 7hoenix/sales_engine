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

  def test_it_returns_a_list_of_all_transactions_with_the_associated_invoice
    sales_engine = SalesEngine.new


    invoice_repo = sales_engine.create_invoice_repository([
                                                              {id: 1},
                                                              {id: 2},
                                                              {id: 3},
                                                              {id: 4},
                                                              {id: 5},
                                                          ])

    sales_engine.create_transaction_repository([
                                                   {id: 10, invoice_id: 1},
                                                   {id: 20, invoice_id: 2},
                                                   {id: 30, invoice_id: 1},
                                                   {id: 40, invoice_id: 3},
                                                   {id: 50, invoice_id: 1},
                                               ])
    invoice = Invoice.new({id: 1}, invoice_repo)
    transactions = invoice.transactions
    assert_equal [10, 30, 50], transactions.map { |transaction| transaction.id }
    end

    def test_it_returns_a_list_of_all_invoice_items_with_the_associated_invoice
      sales_engine = SalesEngine.new


    invoice_repo = sales_engine.create_invoice_repository([
                                                              {id: 1},
                                                              {id: 2},
                                                              {id: 3},
                                                              {id: 4},
                                                              {id: 5},
                                                          ])

    sales_engine.create_invoice_item_repository([
                                                   {id: 10, invoice_id: 1},
                                                   {id: 20, invoice_id: 2},
                                                   {id: 30, invoice_id: 1},
                                                   {id: 40, invoice_id: 3},
                                                   {id: 50, invoice_id: 1},
                                               ])
    invoice = Invoice.new({id: 1}, invoice_repo)

    invoice_items = invoice.invoice_items

    assert_equal [10, 30, 50], invoice_items.map { |invoice_item| invoice_item.id }
  end

  def test_it_returns_a_list_of_items_associated_with_an_invoice_through_invoice_items
    sales_engine = SalesEngine.new

    invoice_repo = sales_engine.create_invoice_repository([
                                                    {id: 2},
                                                    {id: 3},
                                                    {id: 4},
                                                    {id: 6},
                                                          ])

    sales_engine.create_invoice_item_repository([
                      {invoice_id: 5, item_id: 10},
                      {invoice_id: 2, item_id: 20},
                      {invoice_id: 5, item_id: 30},
                      {invoice_id: 4, item_id: 40},
                      {invoice_id: 5, item_id: 50},
                                                ])

    sales_engine.create_item_repository([
                                {id: 10},
                                {id: 20},
                                {id: 30},
                                {id: 40},
                                {id: 50},
                                        ])

    invoice = Invoice.new({id: 5}, invoice_repo)

    items = invoice.items

    assert_equal [10, 30, 50], items.map { |item| item.id }
  end
end
