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
    transactions.collect { |transaction| transaction }
  end

  def random
    transactions.shuffle.first
  end

  def find_by_id(id)
    transactions.find { |transaction| transaction.id == id }
  end

  def find_by_invoice_id(invoice_id)
    transactions.find { |transaction| transaction.invoice_id == invoice_id }
  end

  def find_by_credit_card_number(credit_card_number)
    transactions.find { |transaction| transaction.credit_card_number == credit_card_number }
  end

  def find_by_credit_card_expiration_date(credit_card_expiration_date)
    transactions.find { |transaction| transaction.credit_card_expiration_date == credit_card_expiration_date }
  end

  def find_by_result(result)
    transactions.find { |transaction| transaction.result == result }
  end

  def find_by_created_at(created_at)
    transactions.find { |transaction| transaction.created_at == created_at }
  end

  def find_by_updated_at(updated_at)
    transactions.find { |transaction| transaction.updated_at == updated_at }
  end

  def find_all_by_id(id)
    transactions.select { |transaction| transaction.id == id }
  end

  def find_all_by_invoice_id(invoice_id)
    transactions.select { |transaction| transaction.invoice_id == invoice_id }
  end

  def find_all_by_credit_card_number(credit_card_number)
    transactions.select { |transaction| transaction.credit_card_number == credit_card_number }
  end

  def find_all_by_credit_card_expiration_date(credit_card_expiration_date)
    transactions.select { |transaction| transaction.credit_card_expiration_date == credit_card_expiration_date }
  end

  def find_all_by_result(result)
    transactions.select { |transaction| transaction.result == result }
  end

  def find_all_by_created_at(created_at)
    transactions.select { |transaction| transaction.created_at == created_at }
  end

  def find_all_by_updated_at(updated_at)
    transactions.select { |transaction| transaction.updated_at == updated_at }
  end

  # relationships

  def find_invoice_by_transaction_id(invoice_id)
    sales_engine.find_invoice_by_transaction_id(invoice_id)
  end

  # business intelligence

  def create_new_transaction(new_transaction_data)
    transactions << Transaction.new(new_transaction_data, self)
  end


  # spec harness
  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

end
