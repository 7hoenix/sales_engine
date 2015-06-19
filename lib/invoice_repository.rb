class InvoiceRepository
  attr_reader :sales_engine, :invoice_data, :invoices

  def initialize(invoice_data, sales_engine)
    @invoice_data = invoice_data
    @sales_engine = sales_engine
    @invoices = []
    load_up_data
  end

  def load_up_data
    invoice_data.each do |invoice|
      invoices << Invoice.new(invoice, self)
    end
  end

  def all
    invoices.collect { |invoice| invoice }
  end

  def random
    invoices.shuffle.first
  end

  def find_invoice_by_id(id)
    invoices.find { |invoice| invoice.id == id }
  end

  def find_invoice_by_customer_id(customer_id)
    invoices.find { |invoice| invoice.customer_id == customer_id }
  end

  def find_invoice_by_merchant_id(merchant_id)
    invoices.find { |invoice| invoice.merchant_id == merchant_id }
  end

  def find_invoice_by_status(status)
    invoices.find { |invoice| invoice.status == status }
  end

  def find_invoice_by_created_at(created_at)
    invoices.find { |invoice| invoice.created_at == created_at }
  end

  def find_invoice_by_updated_at(updated_at)
    invoices.find { |invoice| invoice.updated_at == updated_at }
  end

  def find_all_invoices_by_id(id)
    invoices.select { |invoice| invoice.id == id }
  end

  def find_all_invoices_by_customer_id(customer_id)
    invoices.select { |invoice| invoice.customer_id == customer_id }
  end

  def find_all_invoices_by_merchant_id(merchant_id)
    invoices.select { |invoice| invoice.merchant_id == merchant_id }
  end

  def find_all_invoices_by_status(status)
    invoices.select { |invoice| invoice.status == status }
  end

  def find_all_invoices_by_created_at(created_at)
    invoices.select { |invoice| invoice.created_at == created_at }
  end

  def find_all_invoices_by_updated_at(updated_at)
    invoices.select { |invoice| invoice.updated_at == updated_at }
  end

  # relationships

  def find_transactions_for_invoice(invoice_id)
    sales_engine.find_transactions_for_invoice(invoice_id)
  end

  def find_invoice_items_for_invoice(invoice_id)
    sales_engine.find_invoice_items_for_invoice(invoice_id)
  end

  def find_items_for_invoice(invoice_id)
    sales_engine.find_items_for_invoice(invoice_id)
  end

end
