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

  def find_merchant_by_id(id)
    merchants.find { |merchant| merchant.id == id }
  end

  def find_merchant_by_name(name)
    merchants.find { |merchant| merchant.name == name }
  end

  def find_merchant_by_created_at(created_at)
    merchants.find { |merchant| merchant.created_at == created_at }
  end

  def find_merchant_by_updated_at(updated_at)
    merchants.find { |merchant| merchant.updated_at == updated_at }
  end

  def find_all_merchants_by_name(name)
    merchants.select { |merchant| merchant.name == name }
  end

  def find_all_merchants_by_created_at(created_at)
    merchants.select { |merchant| merchant.created_at == created_at }
  end

  def find_all_merchants_by_updated_at(updated_at)
    merchants.select { |merchant| merchant.updated_at == updated_at }
  end


  # relationships

  def find_items_for_merchant(merchant_id)
      sales_engine.find_items_for_merchant(merchant_id)
  end

  def find_invoices_for_merchant(merchant_id)
    sales_engine.find_invoices_for_merchant(merchant_id)
  end

  # spec harness
  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
