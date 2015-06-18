require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'

class MerchantRepositoryTest < Minitest::Test
  def test_it_finds_the_first_example_of_merchant_by_name
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, name: "Walmart"},
        {id: 2, name: "Safeway"},
        {id: 3, name: "Walmart"},]
    repo = MerchantRepository.new(hashes, sales_engine)

    first_merchant = repo.find_merchant_by_name("Walmart")

    assert_equal [1], [first_merchant.id]

    second_merchant = repo.find_merchant_by_name("Safeway")
    assert_equal [2], [second_merchant.id]

    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]

  end

  def test_it_finds_all_examples_of_merchants_by_name
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, name: "Walmart"},
        {id: 2, name: "Safeway"},
        {id: 3, name: "Walmart"},]
    repo = MerchantRepository.new(hashes, sales_engine)

    walmarts = repo.find_all_merchants_by_name("Walmart")
    safeways = repo.find_all_merchants_by_name("Safeway")
    albertsons = repo.find_all_merchants_by_name("Albertsons")

    assert_equal [1, 3], walmarts.map { |walmart| walmart.id }
    assert_equal [2], safeways.map { |safeway| safeway.id }
    assert_equal [], albertsons.map { |albertson| albertson.id }
  end

  def test_it_finds_the_first_example_of_merchant_by_created_at
    skip
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, created_at: Time.now},
        {id: 2, created_at: (Time.now - 1)},
        {id: 3, created_at: (Time.now - 2)},]
    repo = MerchantRepository.new(hashes, sales_engine)

    first_created = repo.find_merchant_by_created_at(Time.now)

    assert_equal [1], [first_created.id]

    second_created = repo.find_merchant_by_created_at(Time.now - 1)
    assert_equal [2], [second_created.id]

    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]

  end

  def test_it_finds_all_examples_of_merchants_by_created_at
    skip
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, created_at: Time.now},
        {id: 2, created_at: (Time.now - 1)},
        {id: 3, created_at: Time.now},]
    repo = MerchantRepository.new(hashes, sales_engine)

    nows = repo.find_all_merchants_by_created_at(Time.now)
    yesterdays = repo.find_all_merchants_by_created_at(Time.now - 1)
    three_days_agos = repo.find_all_merchants_by_created_at(Time.now - 3)

    assert_equal [1, 3], nows.map { |now| now.id }
    assert_equal [2], yesterdays.map { |yesterday| yesterday.id }
    assert_equal [], three_days_agos.map { |three_days_ago| three_days_ago.id }
  end

  def test_it_finds_the_first_example_of_merchant_by_updated_at
    skip
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, updated_at: Time.now},
        {id: 2, updated_at: (Time.now - 1)},
        {id: 3, updated_at: (Time.now - 2)},]
    repo = MerchantRepository.new(hashes, sales_engine)

    first_updated = repo.find_merchant_by_updated_at(Time.now)

    assert_equal [1], [first_updated.id]

    second_updated = repo.find_merchant_by_updated_at(Time.now - 1)
    assert_equal [2], [second_updated.id]

    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]

  end

  def test_it_finds_all_examples_of_merchants_by_updated_at
    skip
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, updated_at: Time.now},
        {id: 2, updated_at: (Time.now - 1)},
        {id: 3, updated_at: Time.now},]
    repo = MerchantRepository.new(hashes, sales_engine)

    nows = repo.find_all_merchants_by_updated_at(Time.now)
    yesterdays = repo.find_all_merchants_by_updated_at(Time.now - 1)
    three_days_agos = repo.find_all_merchants_by_updated_at(Time.now - 3)

    assert_equal [1, 3], nows.map { |now| now.id }
    assert_equal [2], yesterdays.map { |yesterday| yesterday.id }
    assert_equal [], three_days_agos.map { |three_days_ago| three_days_ago.id }
  end


end
