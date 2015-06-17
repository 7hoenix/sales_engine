class Invoice
  attr_reader :invoice_data, :invoice_repository

  def initialize(invoice_data, invoice_repository)
    @invoice_data = invoice_data
    @invoice_repository = invoice_repository
  end

  def id
    invoice_data[:id]
  end

  def customer_id
    invoice_data[:customer_id]
  end

  def merchant_id
    invoice_data[:merchant_id]
  end

  def status
    invoice_data[:status]
  end

  def created_at
    invoice_data[:created_at]
  end

  def updated_at
    invoice_data[:updated_at]
  end

end
