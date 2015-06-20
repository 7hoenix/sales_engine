class InvoiceItem
  attr_reader :invoice_item_repository, :invoice_item_data

  def initialize(invoice_item_data, invoice_item_repository)
    @invoice_item_data = invoice_item_data
    @invoice_item_repository = invoice_item_repository
  end

  def id
    invoice_item_data[:id]
  end

  def item_id
    invoice_item_data[:item_id]
  end

  def invoice_id
    invoice_item_data[:invoice_id]
  end

  def quantity
    invoice_item_data[:quantity]
  end

  def unit_price
    invoice_item_data[:unit_price]
  end

  def created_at
    invoice_item_data[:created_at]
  end

  def updated_at
    invoice_item_data[:updated_at]
  end

  # relationships

  def invoice
    invoice_item_repository.find_invoice_by_invoice_id_for_invoice_item(invoice_id)
  end

  def item
    invoice_item_repository.find_item_by_item_id_for_invoice_item(item_id)
  end

end
