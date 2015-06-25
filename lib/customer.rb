class Customer
  attr_reader :customer_data, :customer_repository

  def initialize(customer_data, customer_repository)
    @customer_data = customer_data
    @customer_repository = customer_repository
  end

  def id
    customer_data[:id].to_i
  end

  def first_name
    customer_data[:first_name]
  end

  def last_name
    customer_data[:last_name]
  end

  def created_at
    Date.parse(customer_data[:created_at])
  end

  def updated_at
    Date.parse(customer_data[:updated_at])
  end

  # relationship

  def invoices
    customer_repository.find_invoices_for_customer(id)
  end

  # business intelligance

  def transactions
    current_customer = customer_repository.find_by_id(id)
    customer_invoices = current_customer.invoices
    customer_invoices.flat_map { |invoice| invoice.transactions }
  end

  def favorite_merchant
    current_customer = customer_repository.find_by_id(id)
    invoices = current_customer.invoices
    transactions = invoices.flat_map { |invoice| invoice.transactions }
    successful_invoices = transactions.flat_map { |transaction|
      transaction.invoice if transaction.result == "success" }
    invoices_by_merchant_id = successful_invoices.compact.group_by { |invoice|
      invoice.merchant_id }
    favorite_merchant_id = invoices_by_merchant_id
                               .sort_by { |merchant_id, invoices|
                                invoices.size }.last[0]
    customer_repository.sales_engine.merchant_repository
        .find_by_id(favorite_merchant_id)
  end

end
