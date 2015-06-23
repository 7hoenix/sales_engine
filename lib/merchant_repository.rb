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
    top_merchants = merchants.sort_by { |merchant| merchant.revenue }.reverse!
    top_merchants[0..(quantity - 1)]
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

  # spec harness
  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
