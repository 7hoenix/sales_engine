require 'date'

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

  def find_by_id(id)
    invoices.find { |invoice| invoice.id == id }
  end

  def find_by_customer_id(customer_id)
    invoices.find { |invoice| invoice.customer_id == customer_id }
  end

  def find_by_merchant_id(merchant_id)
    invoices.find { |invoice| invoice.merchant_id == merchant_id }
  end

  def find_by_status(status)
    invoices.find { |invoice| invoice.status == status }
  end

  def find_by_created_at(created_at)
    invoices.find { |invoice| invoice.created_at == created_at }
  end

  def find_by_updated_at(updated_at)
    invoices.find { |invoice| invoice.updated_at == updated_at }
  end

  def find_all_by_id(id)
    invoices.select { |invoice| invoice.id == id }
  end

  def find_all_by_customer_id(customer_id)
    invoices.select { |invoice| invoice.customer_id == customer_id }
  end

  def find_all_by_merchant_id(merchant_id)
    invoices.select { |invoice| invoice.merchant_id == merchant_id }
  end

  def find_all_by_status(status)
    invoices.select { |invoice| invoice.status == status }
  end

  def find_all_by_created_at(created_at)
    invoices.select { |invoice| invoice.created_at == created_at }
  end

  def find_all_by_updated_at(updated_at)
    invoices.select { |invoice| invoice.updated_at == updated_at }
  end


  # relationships

  def find_transactions_for_invoice(invoice_id)
    sales_engine.find_transactions_for_invoice(invoice_id)
  end

  def find_invoice_items_for_invoice(invoice_id)
    sales_engine.find_invoice_items_for_invoice(invoice_id)
  end

  def find_items_through_invoice_items(invoice_id)
    sales_engine.find_items_through_invoice_items(invoice_id)
  end

  def find_customer_by_customer_id_for_invoice(customer_id)
    sales_engine.find_customer_by_customer_id_for_invoice(customer_id)
  end

  def find_merchant_by_merchant_id_for_invoice(merchant_id)
    sales_engine.find_merchant_by_merchant_id_for_invoice(merchant_id)
  end

  # business intelligencia

  def create(invoice_inputs)
    id = sales_engine.invoice_repository.all.last.id + 1
    current_customer_id = invoice_inputs[:customer].id
    current_merchant_id = invoice_inputs[:merchant].id
    current_status = invoice_inputs[:status]
    created_at = Time.new.to_s
    updated_at = Time.new.to_s

    new_invoice_data = {id: id, customer_id: current_customer_id,
                        merchant_id: current_merchant_id,
                        status: current_status, created_at: created_at,
                        updated_at: updated_at}
    invoices << Invoice.new(new_invoice_data, self)

    items = invoice_inputs[:items]
    items_by_id = items.group_by { |item| item.id }
    quantities = items_by_id.map { |key, value| [key, value.count] }

    sales_engine.invoice_item_repository.create_invoice_items(
        id, quantities)

    invoices.last

  end

  # spec harness

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

end
