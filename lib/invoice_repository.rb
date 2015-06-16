class InvoiceRepository
  attr_reader :repository

  def initialize
    @repository = []
  end

  def <<(invoice)
    repository << [invoice.id, invoice.customer_id, invoice.merchant_id, invoice.status, invoice.created_at, invoice.updated_at]
  end

  def all
    repository.collect { |invoice| invoice }
  end

  def random
    repository.shuffle.first
  end

  def find_by_id(id)
    repository.find { |invoice| invoice[0] == id }
  end

  def find_by_customer_id(customer_id)
    repository.find { |invoice| invoice[1] == customer_id }
  end

  def find_by_merchant_id(merchant_id)
    repository.find { |invoice| invoice[2] == merchant_id }
  end

  def find_by_status(status)
    repository.find { |invoice| invoice[3] == status }
  end

  def find_by_created_at(created_at)
    repository.find { |invoice| invoice[4] == created_at }
  end

  def find_by_updated_at(updated_at)
    repository.find { |invoice| invoice[5] == updated_at }
  end

  def find_all_by_id(id)
    repository.select { |invoice| invoice[0] == id }
  end

  def find_all_by_customer_id(customer_id)
    repository.select { |invoice| invoice[1] == customer_id }
  end

  def find_all_by_merchant_id(merchant_id)
    repository.select { |invoice| invoice[2] == merchant_id }
  end

  def find_all_by_status(status)
    repository.select { |invoice| invoice[3] == status }
  end

  def find_all_by_created_at(created_at)
    repository.select { |invoice| invoice[4] == created_at }
  end

  def find_all_by_updated_at(updated_at)
    repository.select { |invoice| invoice[5] == updated_at }
  end
end
