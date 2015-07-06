require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'
require 'bigdecimal'

class MerchantRepositoryTest < Minitest::Test
  def test_it_finds_the_first_example_of_merchant_by_name
    sales_engine = "MY ENGINE"
    merchant_data = [
        {id: 1, name: "Walmart"},
        {id: 2, name: "Safeway"},
        {id: 3, name: "Walmart"},]
    merchant_repository = MerchantRepository.new(merchant_data, sales_engine)

    first_merchant = merchant_repository.find_by_name("Walmart")

    assert_equal [1], [first_merchant.id]

    second_merchant = merchant_repository.find_by_name("Safeway")
    assert_equal [2], [second_merchant.id]

    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]

  end

  def test_it_finds_all_examples_of_merchants_by_name
    sales_engine = "MY ENGINE"
    merchant_data = [
        {id: 1, name: "Walmart"},
        {id: 2, name: "Safeway"},
        {id: 3, name: "Walmart"},]
    merchant_repository = MerchantRepository.new(merchant_data, sales_engine)

    walmarts = merchant_repository.find_all_by_name("Walmart")
    safeways = merchant_repository.find_all_by_name("Safeway")
    albertsons = merchant_repository.find_all_by_name("Albertsons")

    assert_equal [1, 3], walmarts.map { |walmart| walmart.id }
    assert_equal [2], safeways.map { |safeway| safeway.id }
    assert_equal [], albertsons.map { |albertson| albertson.id }
  end

  def test_it_finds_the_first_example_of_merchant_by_created_at
    sales_engine = "MY ENGINE"

    date1 = "Tue, 20 Mar 2012"
    date2 = "Tue, 19 Mar 2012"
    date3 = "Tue, 18 Mar 2012"

    merchant_data = [
        {id: 1, created_at: date1},
        {id: 2, created_at: date2},
        {id: 3, created_at: date3},]
    merchant_repository = MerchantRepository.new(merchant_data, sales_engine)

    merchant = merchant_repository.find_by_created_at(Date.parse(date1))

    assert_equal 1, merchant.id
    # assert_equal [2], yesterdays.map { |yesterday| yesterday.id }
    # assert_equal [], three_days_agos.map { |three_days_ago| three_days_ago.id }
  end

  def test_it_finds_all_examples_of_merchants_by_created_at
    sales_engine = "MY ENGINE"

    date1 = "Tue, 20 Mar 2012"
    date2 = "Tue, 19 Mar 2012"
    date3 = "Tue, 18 Mar 2012"

    merchant_data = [
        {id: 1, created_at: date1},
        {id: 2, created_at: date2},
        {id: 3, created_at: date1},]
    merchant_repository = MerchantRepository.new(merchant_data, sales_engine)

    merchants = merchant_repository.find_all_by_created_at(Date.parse(date1))

    assert_equal [1, 3], merchants.map { |merchant| merchant.id }
    # assert_equal [2], yesterdays.map { |yesterday| yesterday.id }
    # assert_equal [], three_days_agos.map { |three_days_ago| three_days_ago.id }
  end

  def test_it_finds_the_first_example_of_merchant_by_updated_at
    sales_engine = "MY ENGINE"

    date1 = "Tue, 20 Mar 2012"
    date2 = "Tue, 19 Mar 2012"
    date3 = "Tue, 18 Mar 2012"

    merchant_data = [
        {id: 1, updated_at: date1},
        {id: 2, updated_at: date2},
        {id: 3, updated_at: date1},]
    merchant_repository = MerchantRepository.new(merchant_data, sales_engine)

    merchant = merchant_repository.find_by_updated_at(Date.parse(date1))

    assert_equal 1, merchant.id
    # assert_equal [2], yesterdays.map { |yesterday| yesterday.id }
    # assert_equal [], three_days_agos.map { |three_days_ago| three_days_ago.id }
  end

  def test_it_finds_all_examples_of_merchants_by_updated_at
    sales_engine = "MY ENGINE"

    date1 = "Tue, 20 Mar 2012"
    date2 = "Tue, 19 Mar 2012"
    date3 = "Tue, 18 Mar 2012"

    merchant_data = [
        {id: 1, updated_at: date1},
        {id: 2, updated_at: date2},
        {id: 3, updated_at: date1},]
    merchant_repository = MerchantRepository.new(merchant_data, sales_engine)

    merchants = merchant_repository.find_all_by_updated_at(Date.parse(date1))

    assert_equal [1, 3], merchants.map { |merchant| merchant.id }
    # assert_equal [2], yesterdays.map { |yesterday| yesterday.id }
    # assert_equal [], three_days_agos.map { |three_days_ago| three_days_ago.id }
  end


  def test_it_finds_all_merchants
    sales_engine = "MY ENGINE"
    merchant_data = [{id: 1}, {id: 2}, {id: 3}]
    merchant_repository = MerchantRepository.new(merchant_data, sales_engine)

    merchants = merchant_repository.all

    assert_equal [1, 2, 3], merchants.map { |merchant| merchant.id }
  end

  def test_it_finds_a_merchant_by_id
    sales_engine = "My ENGINE"
    merchant_data = [{id: 1}, {id: 2}, {id: 3}]
    merchant_repository = MerchantRepository.new(merchant_data, sales_engine)

    id = 2

    merchant = merchant_repository.find_by_id(id)

    assert_equal 2, merchant.id
  end

  def test_it_returns_the_top_x_merchants_ranked_in_order_of_total_revenue
    sales_engine = SalesEngine.new

    merchant_repository = sales_engine.create_merchant_repository([
                                                                      {id: 1},
                                                                      {id: 2},
                                                                      {id: 3},
                                                                  ])
    sales_engine.create_invoice_repository([
                                               {id: 10, merchant_id: 1},
                                               {id: 20, merchant_id: 2},
                                               {id: 30, merchant_id: 3},
                                           ])

    sales_engine.create_transaction_repository([
                                                   {id: 100, invoice_id: 10, result: "success"},
                                                   {id: 200, invoice_id: 20, result: "success"},
                                                   {id: 300, invoice_id: 30, result: "success"},
                                               ])
    sales_engine.create_invoice_item_repository([
                                                    {id: 1000, invoice_id: 10, quantity: 1, unit_price: 7700},
                                                    {id: 2000, invoice_id: 20, quantity: 1, unit_price: 7800},
                                                    {id: 3000, invoice_id: 30, quantity: 1, unit_price: 7900},
                                                ])
    top_merchants = merchant_repository.most_revenue(2)
    assert_equal [BigDecimal.new(79), BigDecimal.new(78)], top_merchants.map { |merchant| merchant.revenue }

  end

  def test_it_returns_the_top_x_merchants_ranked_in_order_of_items_sold
    # go through each merchant and find the total number of items sold
    # return the top x number of merchants
    # need: merchant, invoice, invoice item, transaction
    sales_engine = SalesEngine.new

    merchant_repository = sales_engine.create_merchant_repository([
                                                                      {id: 1},
                                                                      {id: 2},
                                                                      {id: 3},
                                                                  ])
    sales_engine.create_invoice_repository([
                                               {id: 10, merchant_id: 1},
                                               {id: 20, merchant_id: 2},
                                               {id: 30, merchant_id: 3},
                                           ])

    sales_engine.create_transaction_repository([
                                                   {id: 100, invoice_id: 10, result: "success"},
                                                   {id: 200, invoice_id: 20, result: "success"},
                                                   {id: 300, invoice_id: 30, result: "success"},
                                               ])
    sales_engine.create_invoice_item_repository([
                                                    {id: 1000, invoice_id: 10, item_id: 10_000},
                                                    {id: 1001, invoice_id: 10, item_id: 10_001},
                                                    {id: 1002, invoice_id: 10, item_id: 10_002},
                                                    {id: 1003, invoice_id: 20, item_id: 10_003},
                                                    {id: 1004, invoice_id: 20, item_id: 10_004},
                                                    {id: 1005, invoice_id: 30, item_id: 10_005},
                                                ])
    top_merchants = merchant_repository.most_items(2)
    assert_equal [1, 2], top_merchants.map { |merchant| merchant.id }
  end

  def test_it_returns_the_total_revenue_for_a_date_across_all_merchants
    sales_engine = SalesEngine.new


    date = "Tue, 20 Mar 2012"
    date2 = "Wed, 21 Mar 2012"

    merchant_repository = sales_engine.create_merchant_repository([
                                                                      {id: 1},
                                                                      {id: 2},
                                                                      {id: 3},
                                                                  ])
    sales_engine.create_invoice_repository([
                                               {id: 10, merchant_id: 1, created_at: date},
                                               {id: 20, merchant_id: 2, created_at: date},
                                               {id: 30, merchant_id: 3, created_at: date2},
                                           ])

    sales_engine.create_transaction_repository([
                                                   {id: 100, invoice_id: 10, result: "success"},
                                                   {id: 200, invoice_id: 20, result: "success"},
                                                   {id: 300, invoice_id: 30, result: "success"},
                                               ])
    sales_engine.create_invoice_item_repository([
                                                    {id: 1000, invoice_id: 10, quantity: 1, unit_price: 7700},
                                                    {id: 2000, invoice_id: 20, quantity: 1, unit_price: 7800},
                                                    {id: 3000, invoice_id: 30, quantity: 1, unit_price: 7900},
                                                ])

    assert_equal BigDecimal.new(155), merchant_repository.revenue(Date.parse(date))
  end
end
