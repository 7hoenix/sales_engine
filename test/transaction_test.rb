require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/transaction_repository'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test

  # relationship
  def test_it_returns_an_invoice_associated_with_a_transaction
    sales_engine = SalesEngine.new

    transaction_repository = TransactionRepository.new([
                                                     {id: 1, invoice_id: 15},
                                                     {id: 2, invoice_id: 30},
                                                     {id: 3, invoice_id: 45},
                                                 ], sales_engine)

    sales_engine.create_invoice_repository([
                                               {id: 15},
                                               {id: 30},
                                               {id: 45},
                                               {id: 60},
                                           ])

    transaction = Transaction.new({id: 4, invoice_id: 60}, transaction_repository)
    invoice = transaction.invoice

    assert_equal 60, invoice.id

  end
end
