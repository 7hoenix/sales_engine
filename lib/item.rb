require 'bigdecimal'
require 'bigdecimal/util'

class Item
  attr_reader :item_repository, :item_data

  def initialize(item_data, item_repository="INSERT REPO")
    @item_data = item_data
    @item_repository = item_repository
  end

  def id
    item_data[:id].to_i
  end

  def name
    item_data[:name]
  end

  def description
    item_data[:description]
  end

  def unit_price
    BigDecimal.new(item_data[:unit_price]) / 100
  end

  def merchant_id
    item_data[:merchant_id].to_i
  end

  def created_at
    Date.parse(item_data[:created_at])
  end

  def updated_at
    Date.parse(item_data[:updated_at])
  end

  # relationship

  def invoice_items
    item_repository.find_invoice_items_by_item_id(id)
  end

  def merchant
    item_repository.find_merchant_for_item(merchant_id)
  end

  # business intelligentsiaaa

  def best_day
    # item to invoice_item

    current_item = item_repository.find_by_id(id)
    invoice_items = current_item.invoice_items
    invoices = invoice_items.map do |invoice_item|
      invoice_item.invoice
    end
    transactions = invoices.flat_map { |invoice| invoice.transactions }
    good_invoices = transactions.flat_map { |transaction| transaction.invoice if transaction.result == "success" }
    good_invoice_items = good_invoices.compact.flat_map { |invoice| invoice.invoice_items }
    invoice_items_by_date = good_invoice_items.group_by { |invoice_item| invoice_item.invoice.created_at }
    dates_with_revenue = invoice_items_by_date.map do |date, invoice_items|
         revenue = invoice_items.reduce(0) do |sum, invoice_item|
           sum + (invoice_item.quantity * invoice_item.unit_price)
         end
         [date, revenue]
    end
    dates_with_revenue.sort_by { |date, revenue| revenue}.last[0]
        # invoice_items_by_date.compact.sort_by { |invoice_item, revenue| revenue }

    # map if successful_invoice_ invoice_items_by_id[invoice_item]

  end

  private

  def successful_transactions_by_invoice_id
    item_repository.sales_engine.transaction_repository
        .find_all_by_result('success')
        .group_by { |transaction| transaction.invoice_id }
  end

  def successful_invoices
    item_repository.sales_engine.invoice_repository.all.select { |invoice| successful_transactions_by_invoice_id[invoice.id] }
  end

  def successful_invoice_items
    successful_invoices.flat_map { |invoice| invoice.invoice_items }
  end

  def invoice_items_by_item_id
    successful_invoice_items.group_by { |invoice_item| invoice_item.item_id }
  end

  def items_by_revenue
    items.map do |item|
      if invoice_items_by_item_id[item.id]
        revenue = invoice_items_by_item_id[item.id].reduce(0) do |sum, ii|
          sum + (ii.quantity * ii.unit_price)
        end
        [item, revenue]
      end
    end
  end

end
