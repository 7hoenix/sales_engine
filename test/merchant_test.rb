require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test
  def test_it_has_a_name
    merchant_data = {id: 1, name: "Walmart"}
    merchant_repository = "MERCHANT REPOSITORY"

    merchant = Merchant.new(merchant_data, merchant_repository)
    assert_equal "Walmart", merchant.name
  end

  def test_it_returns_a_list_of_items_with_the_same_merchant_id

    sales_engine = SalesEngine.new

    sales_engine.create_item_repository([
                {id: 10, merchant_id: 1},
                {id: 20, merchant_id: 2},
                {id: 30, merchant_id: 3},
                {id: 40, merchant_id: 1},
                {id: 50, merchant_id: 9},
                                        ])

    merchant_repo = sales_engine.create_merchant_repository([
                {id: 1},
                {id: 2},
                {id: 3},
                {id: 4},
                {id: 5},
                            ])

    merchant = Merchant.new({id: 1}, merchant_repo)

    items = merchant.items
        # merchant_repo.find_items_for_merchant(merchant.id)

    assert_equal [10, 40], items.map { |item| item.id }
  end

  def test_it_returns_a_collection_of_invoices_associated_with_a_merchant
    sales_engine = SalesEngine.new

    sales_engine.create_invoice_repository([
        {id: 10, merchant_id: 1},
        {id: 20, merchant_id: 2},
        {id: 30, merchant_id: 1},
        {id: 40, merchant_id: 3},
        {id: 50, merchant_id: 1},
    ])

    merchant_repo = sales_engine.create_merchant_repository([
    {id: 1},
    {id: 2},
    {id: 3},
    {id: 4},
    {id: 5},
    ])

    merchant = Merchant.new({id: 1}, merchant_repo)

    invoices = merchant.invoices
        # merchant_repo.find_invoices_for_merchant(merchant.id)

    assert_equal [10, 30, 50], invoices.map { |invoice| invoice.id}
  end

  # def test_it_returns_total_revenue_for_merchant_across_all_transactions
  #   sales_engine = SalesEngine.new
  #
  #   merchant_data = {id: 2}, {id: 3}
  #   merchant_repository = MerchantRepository.new(merchant_data, sales_engine)
  #
  #   sales_engine.create_invoice_repository([
  #                                              {id: 10, merchant_id: 1},
  #                                              {id: 20, merchant_id: 1},
  #                                              {id: 30, merchant_id: 1},
  #                                              {id: 40, merchant_id: 2},
  #                                              {id: 50, merchant_id: 3},
  #                                          ])
  #
  #   sales_engine.create_transaction_repository([
  #                                                  {id: 100, invoice_id: 10, result: "success"},
  #                                                  {id: 200, invoice_id: 20, result: "success"},
  #                                                  {id: 300, invoice_id: 30, result: "failed"},
  #                                              ])
  #
  #   sales_engine.create_invoice_item_repository([
  #                                                   {id: 1000, invoice_id: 10, unit_price: 9000, quantity: 2},
  #                                                   {id: 2000, invoice_id: 20, unit_price: 1000, quantity: 14},
  #                                                   {id: 3000, invoice_id: 30, unit_price: 8001, quantity: 2},
  #                                               ])
  #
  #   merchant = Merchant.new({id: 1}, merchant_repository)
  #
  #   revenue = merchant.revenue
  #
  #   assert_equal 320.00, revenue
  # end


  # def test_it_returns_total_revenue_for_merchant
  #   sales_engine = SalesEngine.new
  #
  #   sales_engine.startup
  #
  #   merchant = sales_engine.merchant_repository.find_by_name("Willms and Sons")
  #
  #   assert_equal 1, merchant.count
  #
  #   revenue = merchant.revenue
  #
  #   assert_equal 320.00, revenue
  #
  # end


end
