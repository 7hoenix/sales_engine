class Transaction
  attr_reader :created_at, :credit_card_number, :transaction_repository, :updated_at, :result, :id, :invoice_id, :credit_card_expiration_date

  def initialize(transaction_data, transaction_repository="INSERT REPOSITORY HERE")
    @id = transaction_data[0]
    @invoice_id = transaction_data[1]
    @credit_card_number = transaction_data[2]
    @credit_card_expiration_date = transaction_data[3]
    @result = transaction_data[4]
    @created_at = transaction_data[5]
    @updated_at = transaction_data[6]
    @transaction_repository = transaction_repository
  end
end
