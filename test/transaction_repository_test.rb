require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction_repository'
require_relative '../lib/transaction'

class TransactionRepositoryTest < Minitest::Test

  def test_it_takes_in_sanitized_data_and_returns_an_array_of_transactions
    skip
    transactor = TransactionRepository.new(transaction_data, engine)
    transactions = transactor.load_up_data
    assert_equal [["1", "1", "4654405418249632", nil, "success", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC"], ["2", "2", "4580251236515201", nil, "success", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC"], ["3", "4", "4354495077693036", nil, "success", "2012-03-27 14:54:10 UTC", "2012-03-27 14:54:10 UTC"], ["4", "5", "4515551623735607", nil, "success", "2012-03-27 14:54:10 UTC", "2012-03-27 14:54:10 UTC"], ["5", "6", "4844518708741275", nil, "success", "2012-03-27 14:54:10 UTC", "2012-03-27 14:54:10 UTC"], ["6", "7", "4203696133194408", nil, "success", "2012-03-27 14:54:10 UTC", "2012-03-27 14:54:10 UTC"], ["7", "8", "4801647818676136", nil, "success", "2012-03-27 14:54:10 UTC", "2012-03-27 14:54:10 UTC"], ["8", "9", "4540842003561938", nil, "success", "2012-03-27 14:54:10 UTC", "2012-03-27 14:54:10 UTC"], ["9", "10", "4140149827486249", nil, "success", "2012-03-27 14:54:10 UTC", "2012-03-27 14:54:10 UTC"], ["10", "11", "4923661117104166", nil, "success", "2012-03-27 14:54:10 UTC", "2012-03-27 14:54:10 UTC"]], transactions
  end

  def test_takes_in_sanitized_transaction_data_from_the_engine
    skip
    transactor = TransactionRepository.new(transaction_data, engine)
    transactor.all
  end

end
