require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_it_finds_the_first_example_of_invoice_item_by_item_id
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, item_id: 500},
        {id: 2, item_id: 520},
        {id: 3, item_id: 500},]
    repo = InvoiceItemRepository.new(hashes, sales_engine)

    first_invoice_item = repo.find_by_item_id(500)

    assert_equal [1], [first_invoice_item.id]

    second_invoice_item = repo.find_by_item_id(520)
    assert_equal [2], [second_invoice_item.id]

  end

  def test_it_finds_all_examples_of_invoice_items_by_item_id
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, item_id: 500},
        {id: 2, item_id: 520},
        {id: 3, item_id: 500},]
    repo = InvoiceItemRepository.new(hashes, sales_engine)

    five_hundreds = repo.find_all_by_item_id(500)
    five_twentys = repo.find_all_by_item_id(520)
    six_hundreds = repo.find_all_by_item_id(600)

    assert_equal [1, 3], five_hundreds.map { |five_hundred| five_hundred.id }
    assert_equal [2], five_twentys.map { |five_twenty| five_twenty.id }
    assert_equal [], six_hundreds.map { |six_hundred| six_hundred.id }
  end

  def test_it_finds_the_first_example_of_invoice_item_by_invoice_id
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, invoice_id: 1},
        {id: 2, invoice_id: 2},
        {id: 3, invoice_id: 1},]
    repo = InvoiceItemRepository.new(hashes, sales_engine)

    first_invoice_item = repo.find_by_invoice_id(1)

    assert_equal [1], [first_invoice_item.id]

    second_invoice_item = repo.find_by_invoice_id(2)
    assert_equal [2], [second_invoice_item.id]

  end

  def test_it_finds_all_examples_of_invoice_items_by_invoice_id
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, invoice_id: 1},
        {id: 2, invoice_id: 2},
        {id: 3, invoice_id: 1},]
    repo = InvoiceItemRepository.new(hashes, sales_engine)

    invoice_ones = repo.find_all_by_invoice_id(1)
    invoice_twos = repo.find_all_by_invoice_id(2)
    invoice_threes = repo.find_all_by_invoice_id(3)

    assert_equal [1, 3], invoice_ones.map { |invoice_one| invoice_one.id }
    assert_equal [2], invoice_twos.map { |invoice_two| invoice_two.id }
    assert_equal [], invoice_threes.map { |invoice_three| invoice_three.id }
  end

  def test_it_finds_the_first_example_of_invoice_item_by_quantity
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, quantity: 5},
        {id: 2, quantity: 6},
        {id: 3, quantity: 5},]
    repo = InvoiceItemRepository.new(hashes, sales_engine)

    first_invoice_item = repo.find_by_quantity(5)

    assert_equal [1], [first_invoice_item.id]

    second_invoice_item = repo.find_by_quantity(6)
    assert_equal [2], [second_invoice_item.id]

  end

  def test_it_finds_all_examples_of_invoice_items_by_quantity
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, quantity: 5},
        {id: 2, quantity: 6},
        {id: 3, quantity: 5},]
    repo = InvoiceItemRepository.new(hashes, sales_engine)

    invoice_fives = repo.find_all_by_quantity(5)
    invoice_sixes = repo.find_all_by_quantity(6)
    invoice_sevens = repo.find_all_by_quantity(7)

    assert_equal [1, 3], invoice_fives.map { |invoice_five| invoice_five.id }
    assert_equal [2], invoice_sixes.map { |invoice_six| invoice_six.id }
    assert_equal [], invoice_sevens.map { |invoice_seven| invoice_seven.id }
  end

  def test_it_finds_the_first_example_of_invoice_item_by_unit_price
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, unit_price: 13635},
        {id: 2, unit_price: 34873},
        {id: 3, unit_price: 13635},]
    repo = InvoiceItemRepository.new(hashes, sales_engine)

    first_invoice_item = repo.find_by_unit_price(13635)

    assert_equal [1], [first_invoice_item.id]

    second_invoice_item = repo.find_by_unit_price(34873)
    assert_equal [2], [second_invoice_item.id]

  end

  def test_it_finds_all_examples_of_invoice_items_by_unit_price
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, unit_price: 13635},
        {id: 2, unit_price: 34873},
        {id: 3, unit_price: 13635},]
    repo = InvoiceItemRepository.new(hashes, sales_engine)

    invoice_thirteen_ks = repo.find_all_by_unit_price(13635)
    invoice_thirty_ks = repo.find_all_by_unit_price(34873)
    invoice_fifteen_ks = repo.find_all_by_unit_price(15000)

    assert_equal [1, 3], invoice_thirteen_ks.map { |invoice_thirteen_k| invoice_thirteen_k.id }
    assert_equal [2], invoice_thirty_ks.map { |invoice_thirty_k| invoice_thirty_k.id }
    assert_equal [], invoice_fifteen_ks.map { |invoice_fifteen_k| invoice_fifteen_k.id }
  end

  def test_it_returns_a_random_instance_of_invoice_item
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, name: "Widget"},
        {id: 2, name: "Dongle"},
        {id: 3, name: "Widget"},]
    repo = InvoiceItemRepository.new(hashes, sales_engine)

    assert repo.random

  end


  def test_it_finds_the_first_example_of_invoice_item_by_created_at
    sales_engine = "MY ENGINE"

    time3 = Time.new - 3
    time5 = Time.new - 5
    time7 = Time.new - 7

    hashes = [
        {id: 1, created_at: (time3)},
        {id: 2, created_at: (time5)},
        {id: 3, created_at: (time7)},]
    repo = InvoiceItemRepository.new(hashes, sales_engine)

    first_created_at = repo.find_by_created_at(time5)

    assert_equal [2], [first_created_at.id]

    second_created_at = repo.find_by_created_at(time7)
    assert_equal [3], [second_created_at.id]

    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]

  end

  def test_it_finds_the_first_example_of_invoice_item_by_updated_at
    sales_engine = "MY ENGINE"

    time3 = Time.new - 3
    time5 = Time.new - 5
    time7 = Time.new - 7

    hashes = [
        {id: 1, updated_at: time3},
        {id: 2, updated_at: time5},
        {id: 3, updated_at: time7},]
    repo = InvoiceItemRepository.new(hashes, sales_engine)

    first_updated_at = repo.find_by_updated_at(time3)

    assert_equal [1], [first_updated_at.id]

    second_updated_at = repo.find_by_updated_at(time5)
    assert_equal [2], [second_updated_at.id]

    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]
  end



end
