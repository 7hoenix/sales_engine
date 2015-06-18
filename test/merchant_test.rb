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
    sales_engine.item_repository = ItemRepository.new([
                {id: 10, merchant_id: 1},
                {id: 20, merchant_id: 2},
                {id: 30, merchant_id: 3},
                {id: 40, merchant_id: 1},
                {id: 50, merchant_id: 9},
            ], sales_engine)

    merchant_repo = sales_engine.merchant_repository

    merchant = Merchant.new({id: 1}, merchant_repo)

    merchant_repo.find_items_for_merchant(merchant.items)

    items = merchant.items

    # items = item_repo.find_all_items_by_merchant_id(merchant_id)

    assert_equal [10, 40], items
  end
end

    # repo = Minitest::Mock.new
    # merchant = Merchant.new(data, repo)
    # repo.expect(:find_items_for_merchant, nil, [1])
    # merchant.items
    # repo.verify
    #
    # engine = Minitest::Mock.new
    # merchant_repo = MerchantRepository(merchant_data_set, engine)
    # engine.expect(:find_items_for_merchant, nil, [1])
    #   merchant_repo.find_by_merchant_id
    # engine.verify
