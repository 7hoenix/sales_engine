class Parser
  def initialize
    @sanitized = []
  end

  def parse_merchant_data(merchant_data)
    merchant_data.each do |row|
      id = row[:id]
      name = row[:name].to_s
      created_at = row[:created_at]
      updated_at = row[:updated_at]
      @sanitized << [id, name, created_at, updated_at]
    end
    @sanitized
  end

  def parse_customer_data(customer_data)
    customer_data.each do |row|
      id = row[:id]
      first_name = row[:first_name].to_s
      last_name = row[:last_name].to_s
      created_at = row[:created_at]
      updated_at = row[:updated_at]
      @sanitized << [id, first_name, last_name, created_at, updated_at]
    end
    @sanitized
  end

  def parse_invoice_item_data(invoice_item_data)
    invoice_item_data.each do |row|
      id = row[:id]
      item_id = row[:item_id]
      invoice_id = row[:invoice_id]
      quantity = row[:quantity]
      unit_price = row[:unit_price]
      created_at = row[:created_at]
      updated_at = row[:updated_at]
      @sanitized << [id, item_id, invoice_id, quantity, unit_price, created_at, updated_at]
    end
    @sanitized
  end

  def parse_invoice_data(invoice_data)
    invoice_data.each do |row|
      id = row[:id]
      customer_id = row[:customer_id]
      merchant_id = row[:merchant_id]
      status = row[:status]
      created_at = row[:created_at]
      updated_at = row[:updated_at]
      @sanitized << [id, customer_id, merchant_id, status, created_at, updated_at]
    end
    @sanitized
  end

  def parse_item_data(item_data)
    item_data.each do |row|
      id = row[:id]
      name = row[:name]
      description = row[:description]
      unit_price = row[:unit_price]
      merchant_id = row[:merchant_id]
      created_at = row[:created_at]
      updated_at = row[:updated_at]
      @sanitized << [id, name, description, unit_price, merchant_id, created_at, updated_at]
    end
    @sanitized
  end

  def parse_transaction_data(transaction_data)
    transaction_data.each do |row|
      id = row[:id]
      invoice_id = row[:invoice_id]
      credit_card_number = row[:credit_card_number]
      credit_card_expiration_date = row[:credit_card_expiration_date]
      result = row[:result]
      created_at = row[:created_at]
      updated_at = row[:updated_at]
      @sanitized << [id, invoice_id, credit_card_number, credit_card_expiration_date, result, created_at, updated_at]
    end
    @sanitized
  end

end
