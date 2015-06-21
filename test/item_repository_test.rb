# id,
# name,
# description,
# unit_price,
# merchant_id,
# created_at,
# updated_at


require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def test_it_finds_item_by_id
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, name: "Widget"},
        {id: 2, name: "Dongle"},
        {id: 3, name: "Widgette"},]
    repo = ItemRepository.new(hashes, sales_engine)

    first_widget = repo.find_by_id(1)

    assert_equal ["Widget"], [first_widget.name]

    dongle = repo.find_by_id(2)

    assert_equal ["Dongle"], [dongle.name]

    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]

  end

  def test_it_finds_the_first_item_by_name
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, name: "Widget"},
        {id: 2, name: "Dongle"},
        {id: 3, name: "Widget"},]
    repo = ItemRepository.new(hashes, sales_engine)

    first_widget = repo.find_by_name("Widget")

    assert_equal [1], [first_widget.id]

    dongle = repo.find_by_name("Dongle")
    assert_equal [2], [dongle.id]

    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]

  end

def test_it_finds_the_first_item_by_description
  sales_engine = "MY ENGINE"
  hashes = [
      {id: 1, description: "Shiny"},
      {id: 2, description: "Dull"},
      {id: 3, description: "Shiny"},]
  repo = ItemRepository.new(hashes, sales_engine)

  first_shiny_thing = repo.find_by_description("Shiny")

  assert_equal [1], [first_shiny_thing.id]

  first_dull_thing = repo.find_by_description("Dull")
  assert_equal [2], [first_dull_thing.id]

  # tv = repo.find_item_by_name("TV")
  # assert_equal [], [tv.id]

end

  def test_it_finds_the_first_item_by_unit_price
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, unit_price: 20},
        {id: 2, unit_price: 30},
        {id: 3, unit_price: 10},]
    repo = ItemRepository.new(hashes, sales_engine)

    unit_price_of_30 = repo.find_by_unit_price(30)
      require 'pry'; binding.pry
    assert_equal [2], [unit_price_of_30.id]
require 'pry'; binding.pry
    unit_price_of_10 = repo.find_by_unit_price(10)
    assert_equal [3], [unit_price_of_10.id]
require 'pry'; binding.pry
    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]

  end

  def test_it_finds_the_first_item_by_merchant_id
    sales_engine = "MY ENGINE"
    hashes = [
    {id: 1, merchant_id: 5},
    {id: 2, merchant_id: 8},
    {id: 3, merchant_id: 7},]
    repo = ItemRepository.new(hashes, sales_engine)

    first_merchant_id = repo.find_by_merchant_id(8)

    assert_equal [2], [first_merchant_id.id]

    second_merchant_id = repo.find_by_merchant_id(7)
    assert_equal [3], [second_merchant_id.id]

    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]

  end

  def test_it_finds_the_first_item_by_created_at

    time3 = Time.new - 3
    time5 = Time.new - 5
    time7 = Time.new - 7

    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, created_at: (time3)},
        {id: 2, created_at: (time5)},
        {id: 3, created_at: (time7)},]
    repo = ItemRepository.new(hashes, sales_engine)

    first_created_at = repo.find_by_created_at(time5)

    assert_equal [2], [first_created_at.id]

    second_created_at = repo.find_by_created_at(time7)
    assert_equal [3], [second_created_at.id]

    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]

  end

  def test_it_finds_the_first_item_by_updated_at

    time3 = Time.new - 3
    time5 = Time.new - 5
    time7 = Time.new - 7

    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, updated_at: time3},
        {id: 2, updated_at: time5},
        {id: 3, updated_at: time7},]
    repo = ItemRepository.new(hashes, sales_engine)

    first_updated_at = repo.find_by_updated_at(time3)

    assert_equal [1], [first_updated_at.id]

    second_updated_at = repo.find_by_updated_at(time5)
    assert_equal [2], [second_updated_at.id]

    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]
  end

  def test_it_finds_all_items_by_id
    sales_engine = "MY ENGINE"
    hashes = [
    {id: 1, name: "Widget"},
    {id: 2, name: "Dongle"},
    {id: 1, name: "Widgette"},]
    repo = ItemRepository.new(hashes, sales_engine)

    widgets = repo.find_all_by_id(1)
    dongles = repo.find_all_by_id(2)
    tvs = repo.find_all_by_id(7)

    assert_equal ["Widget", "Widgette"], widgets.map { |widget| widget.name }
    assert_equal ["Dongle"], dongles.map { |dongle| dongle.name }
    assert_equal [], tvs.map { |tv| tv.id }
  end

def test_it_finds_all_items_by_name
    sales_engine = "MY ENGINE"
    hashes = [
    {id: 1, name: "Widget"},
    {id: 2, name: "Dongle"},
    {id: 3, name: "Widget"},]
    repo = ItemRepository.new(hashes, sales_engine)

    widgets = repo.find_all_by_name("Widget")
    dongles = repo.find_all_by_name("Dongle")
    tvs = repo.find_all_by_name("Tv")

    assert_equal [1, 3], widgets.map { |widget| widget.id }
    assert_equal [2], dongles.map { |dongle| dongle.id }
    assert_equal [], tvs.map { |tv| tv.id }
  end

  def test_it_finds_all_items_by_description

    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, description: "Shiny"},
        {id: 2, description: "Dull"},
        {id: 3, description: "Shiny"},]
    repo = ItemRepository.new(hashes, sales_engine)

    shinys = repo.find_all_by_description("Shiny")
    dulls = repo.find_all_by_description("Dull")
    tvs = repo.find_all_by_description("Tv")

    assert_equal [1, 3], shinys.map { |shiny| shiny.id }
    assert_equal [2], dulls.map { |dull| dull.id }
    assert_equal [], tvs.map { |tv| tv.id }
  end

  def test_it_finds_all_items_by_unit_price

    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, unit_price: 20},
        {id: 2, unit_price: 10},
        {id: 3, unit_price: 20},]
    repo = ItemRepository.new(hashes, sales_engine)

    twenties = repo.find_all_by_unit_price(20)
    tens = repo.find_all_by_unit_price(10)
    tvs = repo.find_all_by_unit_price(45)

    assert_equal [1, 3], twenties.map { |twenty| twenty.id }
    assert_equal [2], tens.map { |ten| ten.id }
    assert_equal [], tvs.map { |tv| tv.id }
  end

  def test_it_finds_all_items_by_merchant_id

    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, merchant_id: 5},
        {id: 2, merchant_id: 8},
        {id: 3, merchant_id: 5},]
    repo = ItemRepository.new(hashes, sales_engine)

    fives = repo.find_all_by_merchant_id(5)
    eights = repo.find_all_by_merchant_id(8)
    tvs = repo.find_all_by_merchant_id(10)

    assert_equal [1, 3], fives.map { |five| five.id }
    assert_equal [2], eights.map { |eight| eight.id }
    assert_equal [], tvs.map { |tv| tv.id }
  end

  def test_it_finds_all_invoices_by_created_at

    time3 = Time.new - 3
    time5 = Time.new - 5
    time7 = Time.new - 7

    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, created_at: (time3)},
        {id: 2, created_at: (time5)},
        {id: 3, created_at: (time7)},
        {id: 5, created_at: (time7)},]

    repo = ItemRepository.new(hashes, sales_engine)

    first_all_created_at = repo.find_all_by_created_at(time7)

    assert_equal [3, 5], first_all_created_at.map { |item| item.id}

    second_created_at = repo.find_all_by_created_at(time5)
    assert_equal [2], second_created_at.map { |item| item.id}

    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]

  end

  def test_it_finds_all_invoices_by_updated_at

    time3 = Time.new - 3
    time5 = Time.new - 5
    time7 = Time.new - 7

    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, updated_at: time3},
        {id: 2, updated_at: time5},
        {id: 3, updated_at: time7},]
    repo = ItemRepository.new(hashes, sales_engine)

    first_updated_at = repo.find_by_updated_at(time3)

    assert_equal [1], [first_updated_at.id]

    second_updated_at = repo.find_by_updated_at(time5)
    assert_equal [2], [second_updated_at.id]

    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]

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
  #
  # def test_it_finds_item_by_unit_price
  #   sales_engine = SalesEngine.new
  #
  #   item_repository = ItemRepository.new([
  #                                            {id: 1, unit_price: 75107},
  #                                            {id: 2, unit_price: 30323},
  #                                            {id: 3, unit_price: 45123},
  #                                        ], sales_engine)
  #
  #   item = item_repository.find_by_unit_price
  #
  #   assert_equal 60, merchant.id
  # end
end
