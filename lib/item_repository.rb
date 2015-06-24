require_relative '../lib/item'

class ItemRepository
  attr_reader :items, :sales_engine, :item_data

  def initialize(item_data, sales_engine)
    @item_data = item_data
    @sales_engine = sales_engine
    @items = []
    load_up_data
  end

  def load_up_data
    item_data.each do |item|
      items << Item.new(item, self)
    end
  end

  def random
    items.shuffle.first
  end

  def all
    items.collect { |item| item }
  end

  def find_by_id(id)
    items.find { |item| item.id == id }
  end

  def find_by_name(name)
    items.find { |item| item.name == name }
  end

  def find_all_by_id(id)
    items.select { |item| item.id == id }
  end

  def find_all_by_name(name)
    items.select { |item| item.name == name }
  end

  def find_by_description(description)
    items.find { |item| item.description == description }
  end

  def find_all_by_description(description)
    items.select { |item| item.description == description }
  end

  def find_by_unit_price(unit_price)
    items.find { |item| item.unit_price == unit_price }
  end

  def find_all_by_unit_price(unit_price)
    items.select { |item| item.unit_price == unit_price }
  end

  def find_by_merchant_id(merchant_id)
    items.find { |item| item.merchant_id == merchant_id }
  end

  def find_all_by_merchant_id(merchant_id)
    items.select { |item| item.merchant_id == merchant_id }
  end

  def find_by_created_at(created_at)
    items.find { |item| item.created_at == created_at }
  end

  def find_all_by_created_at(created_at)
    items.select { |item| item.created_at == created_at }
  end

  def find_by_updated_at(updated_at)
    items.find { |item| item.updated_at == updated_at }
  end

  def find_all_by_updated_at(updated_at)
    items.select { |item| item.updated_at == updated_at }
  end

  # relationship

  def find_invoice_items_by_item_id(item_id)
    sales_engine.find_invoice_items_by_item_id(item_id)
  end

  def find_merchant_for_item(merchant_id)
    sales_engine.find_merchant_for_item(merchant_id)
  end


  # business intelligencia

  def most_revenue(quantity)

    successful_transactions_by_invoice_id = sales_engine.transaction_repository
                                                .find_all_by_result('success')
                                                .group_by { |transaction| transaction.invoice_id }

    successful_invoices = sales_engine.invoice_repository.all.select { |invoice|
      successful_transactions_by_invoice_id[invoice.id]
    }
    successful_invoice_items = successful_invoices.flat_map { |invoice|
      invoice.invoice_items }

    invoice_items_by_item_id = successful_invoice_items.group_by { |invoice_item| invoice_item.item_id }
    items_by_revenue = items.map { |item|
      if invoice_items_by_item_id[item.id]
        revenue = invoice_items_by_item_id[item.id].reduce(0) do |sum, ii|
          sum + (ii.quantity * ii.unit_price)
        end
        [item, revenue]
      end
    }
    items_by_revenue.compact.sort_by { |item, revenue| revenue }.last(quantity)
        .map { |item, revenue| item }
        .reverse

    # items_by_revenue = items.map do |item|
    #   if invoice_items_by_item_id[item.id]
    #     revenue = invoice_items_by_item_id[item.id].reduce(0) do |sum, ii|
    #       sum + (ii.quantity * ii.unit_price)
    #     end
    #     [item, revenue]
    #   end
    # end
    # items_by_revenue.compact.sort_by { |item, revenue| revenue }.last(quantity)
    #     .map { |item, revenue| item }
    #     .reverse
  end

  def most_items(quantity)
    successful_transactions_by_invoice_id = sales_engine.transaction_repository
                                                .find_all_by_result('success')
                                                .group_by { |transaction| transaction.invoice_id }

    successful_invoices = sales_engine.invoice_repository.all.select { |invoice|
      successful_transactions_by_invoice_id[invoice.id]
    }
    successful_invoice_items = successful_invoices.flat_map { |invoice|
      invoice.invoice_items }

    invoice_items_by_item_id = successful_invoice_items.group_by { |invoice_item| invoice_item.item_id }
    items_by_units_sold = items.map { |item|
      if invoice_items_by_item_id[item.id]
        units_sold = invoice_items_by_item_id[item.id].reduce(0) do |sum, ii|
          sum + ii.quantity
        end
        [item, units_sold]
      end
    }
    items_by_units_sold.compact.sort_by { |item, units_sold| units_sold }.last(quantity)
        .map { |item, units_sold| item }
        .reverse
    # invoice_items_by_item_id
    # items_by_units_sold = items.map { |item|
    #   if invoice_items_by_item_id[item.id]
    #     units_sold = invoice_items_by_item_id[item.id].reduce(0) do |sum, ii|
    #       sum + ii.quantity
    #     end
    #     [item, units_sold]
    #   end
    # }
    # items_by_units_sold.compact.sort_by { |item, units_sold| units_sold }.last(quantity)
    #     .map { |item, units_sold| item }
    #     .reverse
  end

  # spec harness
  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  private

  def successful_transactions_by_invoice_id
    sales_engine.transaction_repository
        .find_all_by_result('success')
        .group_by { |transaction| transaction.invoice_id }
  end

  def successful_invoices
    sales_engine.invoice_repository.all.select { |invoice| successful_transactions_by_invoice_id[invoice.id] }
  end

  def successful_invoice_items
    successful_invoices.flat_map { |invoice| invoice.invoice_items }
  end

  def invoice_items_by_item_id
    successful_invoice_items.group_by { |invoice_item| invoice_item.item_id }
  end

  def items_by_revenue

  end

end
