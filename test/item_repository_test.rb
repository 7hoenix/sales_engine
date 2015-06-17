require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def test_it_finds_the_first_example_of_item_by_name
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, name: "Widget"},
        {id: 2, name: "Dongle"},
        {id: 3, name: "Widget"},]
    repo = ItemRepository.new(hashes, sales_engine)

    first_widget = repo.find_item_by_name("Widget")

    assert_equal [1], [first_widget.id]

    dongle = repo.find_item_by_name("Dongle")
    assert_equal [2], [dongle.id]

    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]

  end

  def test_it_finds_all_examples_of_items_by_name
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, name: "Widget"},
        {id: 2, name: "Dongle"},
        {id: 3, name: "Widget"},]
    repo = ItemRepository.new(hashes, sales_engine)

    widgets = repo.find_all_items_by_name("Widget")
    dongles = repo.find_all_items_by_name("Dongle")
    tvs = repo.find_all_items_by_name("Tv")

    assert_equal [1, 3], widgets.map { |widget| widget.id }
    assert_equal [2], dongles.map { |dongle| dongle.id }
    assert_equal [], tvs.map { |tv| tv.id }
  end

  def test_it_returns_a_random_instance_of_item
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, name: "Widget"},
        {id: 2, name: "Dongle"},
        {id: 3, name: "Widget"},]
    repo = ItemRepository.new(hashes, sales_engine)

    assert repo.random

  end

  def test_it_finds_the_first_example_of_item_by_description
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, description: "Shiny"},
        {id: 2, description: "Dull"},
        {id: 3, description: "Shiny"},]
    repo = ItemRepository.new(hashes, sales_engine)

    first_shiny_thing = repo.find_item_by_description("Shiny")

    assert_equal [1], [first_shiny_thing.id]

    first_dull_thing = repo.find_item_by_description("Dull")
    assert_equal [2], [first_dull_thing.id]

    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]

  end

  def test_it_finds_the_first_example_of_item_by_unit_price
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, unit_price: 20},
        {id: 2, unit_price: 30},
        {id: 3, unit_price: 10},]
    repo = ItemRepository.new(hashes, sales_engine)

    unit_price_of_30 = repo.find_item_by_unit_price(30)

    assert_equal [2], [unit_price_of_30.id]

    unit_price_of_10 = repo.find_item_by_unit_price(10)
    assert_equal [3], [unit_price_of_10.id]

    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]

  end

  def test_it_finds_the_first_example_of_item_by_merchant_id
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, merchant_id: 5},
        {id: 2, merchant_id: 8},
        {id: 3, merchant_id: 7},]
    repo = ItemRepository.new(hashes, sales_engine)

    first_merchant_id = repo.find_item_by_merchant_id(8)

    assert_equal [2], [first_merchant_id.id]

    second_merchant_id = repo.find_item_by_merchant_id(7)
    assert_equal [3], [second_merchant_id.id]

    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]

  end

  def test_it_finds_the_first_example_of_item_by_created_at
    skip
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, created_at: (Time.now - 3)},
        {id: 2, created_at: (Time.now - 5)},
        {id: 3, created_at: (Time.now - 7)},]
    repo = ItemRepository.new(hashes, sales_engine)

    first_created_at = repo.find_item_by_created_at(Time.now - 5)

    assert_equal [2], [first_created_at.id]

    second_created_at = repo.find_item_by_created_at(Time.now - 7)
    assert_equal [3], [second_created_at.id]

    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]

  end

  def test_it_finds_the_first_example_of_item_by_updated_at
    skip
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, updated_at: Time.now - 3},
        {id: 1, updated_at: Time.now - 5},
        {id: 1, updated_at: Time.now - 7},]
    repo = ItemRepository.new(hashes, sales_engine)

    first_updated_at = repo.find_item_by_name(Time.now - 3)

    assert_equal [1], [first_updated_at.id]

    second_updated_at = repo.find_item_by_name(Time.now - 5)
    assert_equal [2], [second_updated_at.id]

    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]

  end

  def test_it_finds_all_examples_of_items_by_description

    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, description: "Shiny"},
        {id: 2, description: "Dull"},
        {id: 3, description: "Shiny"},]
    repo = ItemRepository.new(hashes, sales_engine)

    shinys = repo.find_all_items_by_description("Shiny")
    dulls = repo.find_all_items_by_description("Dull")
    tvs = repo.find_all_items_by_description("Tv")

    assert_equal [1, 3], shinys.map { |shiny| shiny.id }
    assert_equal [2], dulls.map { |dull| dull.id }
    assert_equal [], tvs.map { |tv| tv.id }
  end

  def test_it_finds_all_examples_of_items_by_unit_price

    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, unit_price: 20},
        {id: 2, unit_price: 10},
        {id: 3, unit_price: 20},]
    repo = ItemRepository.new(hashes, sales_engine)

    twenties = repo.find_all_items_by_unit_price(20)
    tens = repo.find_all_items_by_unit_price(10)
    tvs = repo.find_all_items_by_unit_price(45)

    assert_equal [1, 3], twenties.map { |twenty| twenty.id }
    assert_equal [2], tens.map { |ten| ten.id }
    assert_equal [], tvs.map { |tv| tv.id }
  end

  def test_it_finds_all_examples_of_items_by_merchant_id

    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, merchant_id: 5},
        {id: 2, merchant_id: 8},
        {id: 3, merchant_id: 5},]
    repo = ItemRepository.new(hashes, sales_engine)

    fives = repo.find_all_items_by_merchant_id(5)
    eights = repo.find_all_items_by_merchant_id(8)
    tvs = repo.find_all_items_by_merchant_id(10)

    assert_equal [1, 3], fives.map { |five| five.id }
    assert_equal [2], eights.map { |eight| eight.id }
    assert_equal [], tvs.map { |tv| tv.id }
  end

end
