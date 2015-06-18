class InvoiceItemRepository
  attr_reader :sales_engine, :invoice_items, :invoice_item_data

  def initialize(invoice_item_data, sales_engine)
    @invoice_item_data = invoice_item_data
    @sales_engine = sales_engine
    @invoice_items = []
    load_up_data
  end

  def load_up_data
    invoice_item_data.each do |invoice_item|
      invoice_items << InvoiceItem.new(invoice_item, self)
    end
  end

  def all
    invoice_items.collect { |invoice_item| invoice_item }
  end

  def random
    invoice_items.shuffle.first
  end

  def find_invoice_item_by_id(id)
    invoice_items.find { |invoice_item| invoice_item.id == id }
  end

  def find_invoice_item_by_item_id(item_id)
    invoice_items.find { |invoice_item| invoice_item.item_id == item_id }
  end

  def find_invoice_item_by_invoice_id(invoice_id)
    invoice_items.find { |invoice_item| invoice_item.invoice_id == invoice_id }
  end

  def find_invoice_item_by_quantity(quantity)
    invoice_items.find { |invoice_item| invoice_item.quantity == quantity }
  end

  def find_invoice_item_by_unit_price(unit_price)
    invoice_items.find { |invoice_item| invoice_item.unit_price == unit_price }
  end

  def find_invoice_item_by_created_at(created_at)
    invoice_items.find { |invoice_item| invoice_item.created_at == created_at }
  end

  def find_invoice_item_by_updated_at(updated_at)
    invoice_items.find { |invoice_item| invoice_item.updated_at == updated_at }
  end

  def find_all_invoice_items_by_id(id)
    invoice_items.select { |invoice_item| invoice_item.id == id }
  end

  def find_all_invoice_items_by_unit_price(unit_price)
    invoice_items.select { |invoice_item| invoice_item.unit_price == unit_price }
  end

  def find_all_invoice_items_by_item_id(item_id)
    invoice_items.select { |invoice_item| invoice_item.item_id == item_id }
  end

  def find_all_invoice_items_by_invoice_id(invoice_id)
    invoice_items.select { |invoice_item| invoice_item.invoice_id == invoice_id }
  end

  def find_all_invoice_items_by_quantity(quantity)
    invoice_items.select { |invoice_item| invoice_item.quantity == quantity }
  end

  def find_all_invoice_items_by_created_at(created_at)
    invoice_items.select { |invoice_item| invoice_item.created_at == created_at }
  end

  def find_all_invoice_items_by_updated_at(updated_at)
    invoice_items.select { |invoice_item| invoice_item.updated_at == updated_at }
  end
end