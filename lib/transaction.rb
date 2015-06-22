class Transaction
  attr_reader :transaction_data, :transaction_repository

  def initialize(transaction_data, transaction_repository)
    @transaction_data = transaction_data
    @transaction_repository = transaction_repository
  end

  def id
    transaction_data[:id].to_i
  end

  def invoice_id
    transaction_data[:invoice_id].to_i
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
    Date.parse(transaction_data[:created_at])
  end

  def updated_at
    Date.parse(transaction_data[:updated_at])
  end

  # relationships

  def invoice
    transaction_repository.find_invoice_by_transaction_id(invoice_id)
  end
end
