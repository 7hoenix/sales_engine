require 'csv'
require_relative 'parser'
require_relative 'merchant_repository'
require_relative 'merchant'
require_relative 'transaction_repository'
require_relative 'transaction'
require 'pry'
# etc...

class SalesEngine
  attr_reader :merchant_data, :customer_data, :transaction_data, :invoice_data, :item_data, :invoice_item_data

  def initialize
    @merchant_data = CSV.open "./test/fixtures/merchants_test.csv", headers: true, header_converters: :symbol
    @customer_data = CSV.open "./test/fixtures/customers_test.csv", headers: true, header_converters: :symbol
    @invoice_item_data = CSV.open "./test/fixtures/invoice_items_test.csv", headers: true, header_converters: :symbol
    @invoice_data = CSV.open "./test/fixtures/invoices_test.csv", headers: true, header_converters: :symbol
    @item_data = CSV.open "./test/fixtures/items_test.csv", headers: true, header_converters: :symbol
    @transaction_data = CSV.open "./test/fixtures/transactions_test.csv", headers: true, header_converters: :symbol
  end

  def parse_merchant_data
    parser = Parser.new
    parser.parse_merchant_data(@merchant_data)
  end

  def create_merchant_repository
    MerchantRepository.new(parse_merchant_data, self)
  end

  def parse_customer_data
    parser = Parser.new
    sanitized_customer_data = parser.parse_customer_data(@customer_data)
  end

  def create_customer_repository
    CustomerRepository.new(parse_customer_data, self)
  end

  def parse_invoice_item_data
    parser = Parser.new
    sanitized_invoice_item_data = parser.parse_invoice_item_data(@invoice_item_data)
  end

  def create_invoice_item_repository
    InvoiceItemRepository.new(parse_invoice_item_data, self)
  end

  def parse_invoice_data
    parser = Parser.new
    sanitized_invoice_data = parser.parse_invoice_data(@invoice_data)
  end

  def create_invoice_repository
    InvoiceRepository.new(parse_invoice_data, self)
  end

  def parse_item_data
    parser = Parser.new
    sanitized_item_data = parser.parse_item_data(@item_data)
  end

  def create_item_repository
    ItemRepository.new(parse_item_data, self)
  end

  def parse_transaction_data
    parser = Parser.new
    sanitized_transaction_data = parser.parse_transaction_data(@transaction_data)
  end

  def create_transaction_repository
    TransactionRepository.new(parse_transaction_data, self)
  end

end

e = SalesEngine.new
e.create_merchant_repository
