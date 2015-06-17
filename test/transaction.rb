require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction_repository'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test
  def test_it_can_make_a_new_transaction
    transaction_data = ["1", "1", "4654405418249632", nil, "success", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC"]
    transaction_repository = "INSERT REPO HERE"
    transaction = Transaction.new(transaction_data, transaction_repository)

    assert transaction
  end

  def test_a_new_transaction_has_an_id
    transaction_data = ["1", "1", "4654405418249632", nil, "success", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC"]
    transaction_repository = "INSERT REPO HERE"
    transaction = Transaction.new(transaction_data, transaction_repository)

    assert_equal "4654405418249632", transaction.credit_card_number
  end

  def test_a_new_transaction_has_a_result
    transaction_data = ["1", "1", "4654405418249632", nil, "success", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC"]
    transaction_repository = "INSERT REPO HERE"
    transaction = Transaction.new(transaction_data, transaction_repository)

    assert_equal "success", transaction.result
  end

  def test_a_new_transaction_has_an_invoice_id
      transaction_data = ["1", "1", "4654405418249632", nil, "success", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC"]
      transaction_repository = "INSERT REPO HERE"
      transaction = Transaction.new(transaction_data, transaction_repository)

      assert_equal "1", transaction.invoice_id
  end
end
