require 'minitest/autorun'
require 'minitest/pride'
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

    assert_equal [15,60], invoice_items.map { |invoice_item| invoice_item.id}
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
                                                {id: 60}
                                            ])

    item = Item.new({id: 4, merchant_id: 60}, item_repository)

    merchant = item.merchant

    assert_equal 60, merchant.id
  end

end
