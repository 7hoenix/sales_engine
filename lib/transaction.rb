class Transaction
  attr_reader :transaction_data, :transaction_repository

  def initialize(transaction_data, transaction_repository)
    @transaction_data = transaction_data
    @transaction_repository = transaction_repository
  end

  def id
    transaction_data[:id]
  end

  def invoice_id
    transaction_data[:invoice_id]
  end

  def credit_card_number
    transaction_data[:credit_card_number]
  end

  def credit_card_expiration_date
    transaction_data[:credit_card_expiration_date]
  end

  def result
    transaction_data[:result]
  end

  def created_at
    transaction_data[:created_at]
  end

  def updated_at
    transaction_data[:updated_at]
  end

  def transaction_repository
    transaction_repository[:transaction_repository]
  end
end
