require_relative 'invoice_item'

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

  def find_by_id(id)
    invoice_items.find { |invoice_item| invoice_item.id == id }
  end

  def find_by_item_id(item_id)
    invoice_items.find { |invoice_item| invoice_item.item_id == item_id }
  end

  def find_by_invoice_id(invoice_id)
    invoice_items.find { |invoice_item| invoice_item.invoice_id == invoice_id }
  end

  def find_by_quantity(quantity)
    invoice_items.find { |invoice_item| invoice_item.quantity == quantity }
  end

  def find_by_unit_price(unit_price)
    invoice_items.find { |invoice_item| invoice_item.unit_price == unit_price }
  end

  def find_by_created_at(created_at)
    invoice_items.find { |invoice_item| invoice_item.created_at == created_at }
  end

  def find_by_updated_at(updated_at)
    invoice_items.find { |invoice_item| invoice_item.updated_at == updated_at }
  end

  def find_all_by_id(id)
    invoice_items.select { |invoice_item| invoice_item.id == id }
  end

  def find_all_by_unit_price(unit_price)
    invoice_items.select { |invoice_item| invoice_item.unit_price == unit_price }
  end

  def find_all_by_item_id(item_id)
    invoice_items.select { |invoice_item| invoice_item.item_id == item_id }
  end

  def find_all_by_invoice_id(invoice_id)
    invoice_items.select { |invoice_item| invoice_item.invoice_id == invoice_id }
  end

  def find_all_by_quantity(quantity)
    invoice_items.select { |invoice_item| invoice_item.quantity == quantity }
  end

  def find_all_by_created_at(created_at)
    invoice_items.select { |invoice_item| invoice_item.created_at == created_at }
  end

  def find_all_by_updated_at(updated_at)
    invoice_items.select { |invoice_item| invoice_item.updated_at == updated_at }
  end


  # relationships

  def find_invoice_by_invoice_id_for_invoice_item(invoice_id)
    sales_engine.find_invoice_by_invoice_id_for_invoice_item(invoice_id)
  end

  def find_item_by_item_id_for_invoice_item(item_id)
    sales_engine.find_item_by_item_id_for_invoice_item(item_id)
  end

  # business intelligence

  def create_invoice_items(invoice_id, quantities)
    quantities.each do |quantity|
      id = sales_engine.invoice_item_repository.all.last.id + 1
      unit_price = sales_engine.item_repository.find_by_id(quantity[0]).unit_price.to_s
      created_at = Date.new
      updated_at = Date.new
      new_invoice_item_data = {id: id, item_id: quantity[0], invoice_id: invoice_id, quantity: quantity[1], unit_price: unit_price}
      invoice_items << InvoiceItem.new(new_invoice_item_data, self)
    end
    invoice_items.last(quantities.size)
  end

  # spec harness
  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end
end
