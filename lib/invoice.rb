class Invoice
  attr_reader :invoice_data, :invoice_repository

  def initialize(invoice_data, invoice_repository)
    @invoice_data = invoice_data
    @invoice_repository = invoice_repository
  end

  def id
    invoice_data[:id].to_i
  end

  def customer_id
    invoice_data[:customer_id].to_i
  end

  def merchant_id
    invoice_data[:merchant_id].to_i
  end

  def status
    invoice_data[:status]
  end

  def created_at
    Date.parse(invoice_data.fetch(:created_at))
  end

  def updated_at
    Date.parse(invoice_data[:updated_at])
  end


  # relationships

  def transactions
    invoice_repository.find_transactions_for_invoice(id)
  end

  def invoice_items
    invoice_repository.find_invoice_items_for_invoice(id)
  end

  def items
    invoice_repository.find_items_through_invoice_items(id)
  end

  def customer
    invoice_repository.find_customer_by_customer_id_for_invoice(customer_id)
  end

  def merchant
    invoice_repository.find_merchant_by_merchant_id_for_invoice(merchant_id)
  end

  # business intelligence

  def charge(transaction_inputs)
    transaction_id = invoice_repository.sales_engine.transaction_repository
                         .all.last.id + 1
    current_invoice_id = id
    credit_card_number = transaction_inputs[:credit_card_number]
    credit_card_exp_date = transaction_inputs[:credit_card_expiration_date]
    result = transaction_inputs[:result]
    created_at = Time.now.to_s
    updated_at = Time.now.to_s

    new_transaction_data = {id: transaction_id, invoice_id: current_invoice_id,
                            credit_card_number: credit_card_number,
                            credit_card_expiration_date: credit_card_exp_date,
                            result: result, created_at: created_at,
                            updated_at: updated_at }
    invoice_repository.sales_engine.transaction_repository
        .create_new_transaction(new_transaction_data)
  end
end
