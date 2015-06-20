require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'

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
    t = Time.now
    merchant_data = [
        {id: 1, created_at: t},
        {id: 2, created_at: t - 200},
        {id: 3, created_at: t},]
    merchant_repository = MerchantRepository.new(merchant_data, sales_engine)

    merchant = merchant_repository.find_by_created_at(t)

    assert_equal 1, merchant.id
    # assert_equal [2], yesterdays.map { |yesterday| yesterday.id }
    # assert_equal [], three_days_agos.map { |three_days_ago| three_days_ago.id }
  end

  def test_it_finds_all_examples_of_merchants_by_created_at
    sales_engine = "MY ENGINE"
    t = Time.now
    merchant_data = [
        {id: 1, created_at: t},
        {id: 2, created_at: t - 200},
        {id: 3, created_at: t},]
    merchant_repository = MerchantRepository.new(merchant_data, sales_engine)

    merchants = merchant_repository.find_all_by_created_at(t)

    assert_equal [1, 3], merchants.map { |merchant| merchant.id }
    # assert_equal [2], yesterdays.map { |yesterday| yesterday.id }
    # assert_equal [], three_days_agos.map { |three_days_ago| three_days_ago.id }
  end

  def test_it_finds_the_first_example_of_merchant_by_updated_at
    sales_engine = "MY ENGINE"
    t = Time.now
    merchant_data = [
        {id: 1, updated_at: t},
        {id: 2, updated_at: t - 200},
        {id: 3, updated_at: t},]
    merchant_repository = MerchantRepository.new(merchant_data, sales_engine)

    merchant = merchant_repository.find_by_updated_at(t)

    assert_equal 1, merchant.id
    # assert_equal [2], yesterdays.map { |yesterday| yesterday.id }
    # assert_equal [], three_days_agos.map { |three_days_ago| three_days_ago.id }
  end

  def test_it_finds_all_examples_of_merchants_by_updated_at
    sales_engine = "MY ENGINE"
    t = Time.now
    merchant_data = [
        {id: 1, updated_at: t},
        {id: 2, updated_at: t - 200},
        {id: 3, updated_at: t},]
    merchant_repository = MerchantRepository.new(merchant_data, sales_engine)

    merchants = merchant_repository.find_all_by_updated_at(t)

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


end
