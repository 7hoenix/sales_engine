require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/item'

class ItemTest < Minitest::Test
  def test_it_has_a_name
    item_data = {id: 1, name: "Widget"}
    item_repository = "ITEM REPOSITORY"
    item = Item.new(item_data, item_repository)

    assert_equal "Widget", item.name
  end

  def test_it_finds_all_invoice_items_associated_with_this_item
    sales_engine = SalesEngine.new

    item_repository = ItemRepository.new([
                                             {id: 1},
                                             {id: 2},
                                             {id: 3},
                                         ], sales_engine)

    sales_engine.create_invoice_item_repository([
                                                    {id: 15, item_id: 4},
                                                    {id: 30, item_id: 2},
                                                    {id: 45, item_id: 3},
                                                    {id: 60, item_id: 4}
                                                ])

    item = Item.new({id: 4}, item_repository)

    invoice_items = item.invoice_items

    assert_equal [15, 60], invoice_items.map { |invoice_item| invoice_item.id }
  end

  def test_it_finds_the_merchant_associated_with_an_item
    sales_engine = SalesEngine.new

    item_repository = ItemRepository.new([
                                             {id: 1, merchant_id: 15},
                                             {id: 2, merchant_id: 30},
                                             {id: 3, merchant_id: 45},
                                         ], sales_engine)

    sales_engine.create_merchant_repository([
                                                {id: 15},
                                                {id: 30},
                                                {id: 45},
                                                {id: 60},
                                            ])

    item = Item.new({id: 4, merchant_id: 60}, item_repository)

    merchant = item.merchant

    assert_equal 60, merchant.id
  end

  def test_it_returns_the_date_with_the_most_sales_for_a_given_item
    sales_engine = SalesEngine.new

    item_repository = sales_engine.create_item_repository([
                                                              {id: 1},
                                                              {id: 2},
                                                              {id: 3},
                                                          ])
    sales_engine.create_invoice_item_repository([
                                                    {id: 10, item_id: 2, invoice_id: 100, quantity: 1, unit_price: 75},
                                                    {id: 20, item_id: 2, invoice_id: 200, quantity: 2, unit_price: 76},
                                                    {id: 30, item_id: 3, invoice_id: 300, quantity: 1, unit_price: 77},
                                                    {id: 40, item_id: 2, invoice_id: 400, quantity: 3, unit_price: 78},
                                                    {id: 50, item_id: 1, invoice_id: 500, quantity: 1, unit_price: 79},
                                                ])
    sales_engine.create_invoice_repository([
                                               {id: 100, created_at: "Tue, 20 Mar 2012"},
                                               {id: 200, created_at: "Wed, 21 Mar 2012"},
                                               {id: 300, created_at: "Tue, 22 Mar 2012"},
                                               {id: 400, created_at: "Wed, 21 Mar 2012"},
                                               {id: 500, created_at: "Tue, 20 Mar 2012"},
                                           ])

    sales_engine.create_transaction_repository([
                                                   {id: 1001, invoice_id: 100, result: "success"},
                                                   {id: 1002, invoice_id: 200, result: "success"},
                                                   {id: 1003, invoice_id: 300, result: "success"},
                                                   {id: 1004, invoice_id: 400, result: "success"},
                                                   {id: 1005, invoice_id: 500, result: "failed"},
                                               ])

    item = item_repository.find_by_id(2)

    best_day = item.best_day

    assert_equal Date.parse("Wed, 21 Mar 2012"), best_day
  end

end
