class MerchantRepository
  attr_reader :sales_engine, :merchant_data, :merchants

  def initialize(merchant_data, sales_engine)
    @merchant_data = merchant_data
    @sales_engine = sales_engine
    @merchants = []
    load_up_data
  end

  def load_up_data
    merchant_data.each do |merchant|
      merchants << Merchant.new(merchant, self)
    end
  end

  def all
    merchants.collect { |merchant| merchant }
  end

  def random
    merchants.shuffle.first
  end

  def find_by_id(id)
    merchants.find { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    merchants.find { |merchant| merchant.name == name }
  end

  def find_by_created_at(created_at)
    merchants.find { |merchant| merchant.created_at == created_at }
  end

  def find_by_updated_at(updated_at)
    merchants.find { |merchant| merchant.updated_at == updated_at }
  end

  def find_all_by_name(name)
    merchants.select { |merchant| merchant.name == name }
  end

  def find_all_by_created_at(created_at)
    merchants.select { |merchant| merchant.created_at == created_at }
  end

  def find_all_by_updated_at(updated_at)
    merchants.select { |merchant| merchant.updated_at == updated_at }
  end


  # relationships

  def find_items_for_merchant(merchant_id)
    sales_engine.find_items_for_merchant(merchant_id)
  end

  def find_invoices_for_merchant(merchant_id)
    sales_engine.find_invoices_for_merchant(merchant_id)
  end


  # business intelligence

  def find_revenue_for_merchant(merchant_id, date)
    sales_engine.find_revenue_for_merchant(merchant_id, date)
  end

  def find_favorite_customer_for_merchant(merchant_id)
    sales_engine.find_favorite_customer_for_merchant(merchant_id)
  end

  def find_customers_with_pending_invoices_for_merchant(merchant_id)
    sales_engine.find_customers_with_pending_invoices_for_merchant(merchant_id)
  end

  # most revenue
  def most_revenue(quantity)

      successful_transactions_by_invoice_id = sales_engine.transaction_repository
      .find_all_by_result('success')
      .group_by { |txn| txn.invoice_id }

      # {'1' => {}}.inject({}) do |memo, (k,v)|
      #     Invoice.find(k)
      #   end
      # end

      successful_invoices = sales_engine.invoice_repository.all.select { |invoice|
       successful_transactions_by_invoice_id[invoice.id]
        }
      invoices_by_merchant_id = successful_invoices.group_by { |invoice| invoice.merchant_id }

      invoice_items_by_invoice_id = sales_engine.invoice_item_repository.all.group_by { |ii| ii.invoice_id }

      invoice_items_by_merchant_id = invoices_by_merchant_id.map { |merchant_id, invoices|
      invoice_items = invoices.flat_map { |invoice| invoice_items_by_invoice_id.fetch(invoice.id, []) }
       [merchant_id, invoice_items]
       }.to_h

       merchants_by_revenue = merchants.map { |merchant|
      revenue = invoice_items_by_merchant_id[merchant.id].reduce(0) do |sum, ii|
        sum + (ii.quantity * ii.unit_price)

        end
        [merchant, revenue]
        }
       merchants_by_revenue.sort_by { |merchant, revenue| revenue }.last(quantity)
      .map { |merchant, revenue| merchant }
      .reverse

    #
    # top_merchants = merchants.sort_by { |merchant| merchant.revenue }.reverse!
    # top_merchants[0..(quantity - 1)]
  end

  # most items
  def most_items(quantity)
    top_merchants = merchants.sort_by do |merchant|
      invoices = merchant.invoices
      transactions = invoices.flat_map { |invoice| invoice.transactions }
      good_invoices = transactions.flat_map { |transaction| transaction.invoice if transaction.result == "success" }
      invoice_items = good_invoices.compact.flat_map { |invoice| invoice.invoice_items.count }
      invoice_items.reduce(:+)
    end
                        .reverse!
    top_merchants[0..(quantity - 1)]
  end

  # revenue by date
  def revenue(date)
    merchant_revenue = merchants.compact.flat_map { |merchant| merchant.revenue(date) }
    merchant_revenue.compact.reduce(:+)
  end

  # spec harness
  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
