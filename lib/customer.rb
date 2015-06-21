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
    customer_data[:created_at]
  end

  def updated_at
    customer_data[:updated_at]
  end

#   relationship

  def invoices
    customer_repository.find_invoices_for_customer(id)
  end

end
