require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchant_repository

  def setup

    merchant_data = [[1, "Jack", "2012-03-27 14:53:58 UTC", "2012-03-27 14:53:58 UTC"], [2, "Jill", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], [3, "Frank", "2012-03-27 14:53:60 UTC", "2012-03-27 14:53:60 UTC"]]
    @merchant_repository = MerchantRepository.new(merchant_data, "self")

  end

  def test_it_loads_merchant_data
    skip
    actual_merchant_repository = MerchantRepository.new()
    merchant_data = actual_merchant_repository.merchant_data

    assert_equal "1, Schroeder-Jerde, 2012-03-27 14 : 53 : 59 UTC, 2012-03-27 14 : 53 : 59 UTC " +
                     "2, \"Klein, Rempel and Jones\", 2012-03-27 14 : 53 : 59 UTC, 2012-03-27 14 : 53 : 59 UTC" +
                     "3, Willms and Sons, 2012-03-27 14 : 53 : 59 UTC, 2012-03-27 14 : 53 : 59 UTC" +
                     "4, Cummings-Thiel, 2012-03-27 14 : 53 : 59 UTC, 2012-03-27 14 : 53 : 59 UTC" +
                     "5, Williamson Group, 2012-03-27 14 : 53 : 59 UTC, 2012-03-27 14 : 53 : 59 UTC" +
                     "6, Williamson Group, 2012-03-27 14 : 53 : 59 UTC, 2012-03-27 16 : 12 : 25 UTC" +
                     "7, Bernhard-Johns, 2012-03-27 14 : 53 : 59 UTC, 2012-03-27 14 : 53 : 59 UTC" +
                     "8, \"Osinski, Pollich and Koelpin\", 2012-03-27 14 : 53 : 59 UTC, 2012-03-27 14 : 53 : 59 UTC" +
                     "9, Hand-Spencer, 2012-03-27 14 : 53 : 59 UTC, 2012-03-27 14 : 53 : 59 UTC" +
                     "10, \"Bechtelar, Jones and Stokes\", 2012-03-27 14 : 54 : 00 UTC, 2012-03-27 14 : 54 : 00 UTC, merchants", merchant_data
  end

  def test_it_exist
    skip
    assert merchant_repository
  end

  def test_the_repository_count_goes_up_by_three_when_you_add_three_instances_of_a_merchant
    assert_equal 3, merchant_repository.merchants.count
  end

  def test_it_returns_all_instances_when_the_all_method_is_called
    all_merchants = merchant_repository.all

    expected = [[1, "Jack", "2012-03-27 14:53:58 UTC", "2012-03-27 14:53:58 UTC"], [2, "Jill", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], [3, "Frank", "2012-03-27 14:53:60 UTC", "2012-03-27 14:53:60 UTC"]]
    assert_equal expected, all_merchants
  end

  def test_it_returns_a_random_instance_when_the_random_method_is_called
    skip
    # figure out how to stub so we can actually test this
    merchant = Merchant.new(1, "Jack", "2012-03-27 14:53:58 UTC", "2012-03-27 14:53:58 UTC")
    merchant2 = Merchant.new(2, "Jill", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC")
    merchants << merchant
    merchants << merchant2

    random_merchant = merchant_repository.random

    expected = [1, "Jack", "2012-03-27 14:53:58 UTC", "2012-03-27 14:53:58 UTC"]
    assert_equal expected, random_merchant
  end

  def test_it_finds_an_instance_of_merchant_by_searching_for_id
    skip
    id = 2

    merchant_by_id = merchant_repository.find_by_id(id)

    expected = [2, "Jill", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"]

    assert_equal expected, merchant_by_id
  end

  def test_it_finds_an_instance_of_merchant_by_searching_for_name
    skip
    name = "Jill"

    merchant_by_name = merchant_repository.find_by_name(name)

    expected = [2, "Jill", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"]

    assert_equal expected, merchant_by_name
  end

  def test_it_finds_an_instance_of_merchant_by_searching_for_created_at
    skip
    created_at = "2012-03-27 14:53:59 UTC"

    merchant_by_created_at = merchant_repository.find_by_created_at(created_at)

    expected = [2, "Jill", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"]

    assert_equal expected, merchant_by_created_at
  end

  def test_it_finds_an_instance_of_merchant_by_searching_for_updated_at
    skip
    updated_at = "2012-03-27 14:53:59 UTC"

    merchant_by_updated_at = merchant_repository.find_by_updated_at(updated_at)

    expected = [2, "Jill", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"]

    assert_equal expected, merchant_by_updated_at
  end

  def test_it_finds_all_instances_of_merchant_by_searching_for_id
    skip
    merchant4 = Merchant.new(2, "Jelly Bean", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC")
    merchants << merchant4

    id = 2

    all_merchants_by_id = merchant_repository.find_all_by_id(id)
    expected = [[2, "Jill", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], [2, "Jelly Bean", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"]]

    assert_equal expected, all_merchants_by_id
  end

  def test_it_finds_all_instances_of_merchant_by_searching_for_name
    skip
    merchant4 = Merchant.new(4, "Jill", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC")
    merchants << merchant4

    name = "Jill"

    all_merchants_by_name = merchant_repository.find_all_by_name(name)
    expected = [[2, "Jill", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], [4, "Jill", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"]]

    assert_equal expected, all_merchants_by_name
  end

  def test_it_finds_all_instances_of_merchant_by_searching_for_created_at
    skip
    row = [6, "Jelly Bean", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"]
    merchant4 = Merchant.new(row, merchant_repository)
    merchants << merchant4

    created_at = "2012-03-27 14:53:59 UTC"

    all_merchants_by_created_at = merchant_repository.find_all_by_created_at(created_at)
    expected = [[2, "Jill", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], [6, "Jelly Bean", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"]]

    assert_equal expected, all_merchants_by_created_at
  end

  def test_it_finds_all_instances_of_merchant_by_searching_for_updated_at
    skip
    row = [7, "Jelly Bean", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"]
    merchant4 = Merchant.new(row, merchant_repository)
    merchants << merchant4

    updated_at = "2012-03-27 14:53:59 UTC"

    all_merchants_by_updated_at = merchant_repository.find_all_by_updated_at(updated_at)
    expected = [[2, "Jill", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], [7, "Jelly Bean", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"]]

    assert_equal expected, all_merchants_by_updated_at
  end

end
