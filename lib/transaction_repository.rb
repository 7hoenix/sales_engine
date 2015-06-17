require_relative '../lib/transaction'

class TransactionRepository
  attr_reader :sales_engine, :transaction_data, :transactions

  def initialize(transaction_data, sales_engine)
    @transaction_data = transaction_data
    @sales_engine = sales_engine
    @transactions = []
    load_up_data
  end

  def load_up_data
    transaction_data.each do |transaction|
      transactions << Transaction.new(transaction, self)
    end
  end

  def all
    transactions.collect { |transaction| [transaction.id, transaction.invoice_id, transaction.credit_card_number, transaction.credit_card_expiration_date, transaction.result, transaction.created_at, transaction.updated_at] }
  end

  def random
    transactions.shuffle.first
  end

  def find_by_id(id)
    transactions.find { |transaction| transaction[0] == id }
  end

  def find_by_invoice_id(invoice_id)
    transactions.find { |transaction| transaction[1] == invoice_id }
  end

  def find_by_credit_card_number(credit_card_number)
    transactions.find { |transaction| transaction[2] == credit_card_number }
  end

  def find_by_credit_card_expiration_date(credit_card_expiration_date)
    transactions.find { |transaction| transaction[3] == credit_card_expiration_date }
  end

  def find_by_result(result)
    transactions.find { |transaction| transaction[4] == result }
  end

  def find_by_created_at(created_at)
    transactions.find { |transaction| transaction[5] == created_at }
  end

  def find_by_updated_at(updated_at)
    transactions.find { |transaction| transaction[6] == updated_at }
  end


  def find_all_by_invoice_id(invoice_id)
    transactions.select { |transaction| transaction[1] == invoice_id }
  end

  def find_all_by_credit_card_number(credit_card_number)
    transactions.select { |transaction| transaction[2] == credit_card_number }
  end

  def find_all_by_credit_card_expiration_date(credit_card_expiration_date)
    transactions.select { |transaction| transaction[3] == credit_card_expiration_date }
  end

  def find_all_by_result(result)
    transactions.select { |transaction| transaction[4] == result }
  end

  def find_all_by_created_at(created_at)
    transactions.select { |transaction| transaction[5] == created_at }
  end

  def find_all_by_updated_at(updated_at)
    transactions.select { |transaction| transaction[6] == updated_at }
  end

end
