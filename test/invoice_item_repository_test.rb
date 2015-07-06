require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
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

    first_invoice_item = repo.find_by_unit_price(136.35)

    assert_equal [1], [first_invoice_item.id]

    second_invoice_item = repo.find_by_unit_price(348.73)
    assert_equal [2], [second_invoice_item.id]

  end

  def test_it_finds_all_examples_of_invoice_items_by_unit_price
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, unit_price: 13635},
        {id: 2, unit_price: 34873},
        {id: 3, unit_price: 13635},]
    repo = InvoiceItemRepository.new(hashes, sales_engine)

    invoice_thirteen_ks = repo.find_all_by_unit_price(136.35)
    invoice_thirty_ks = repo.find_all_by_unit_price(348.73)
    invoice_fifteen_ks = repo.find_all_by_unit_price(150.00)

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

    date1 = "Tue, 20 Mar 2012"
    date2 = "Tue, 19 Mar 2012"
    date3 = "Tue, 18 Mar 2012"

    hashes = [
        {id: 1, created_at: date1},
        {id: 2, created_at: date2},
        {id: 3, created_at: date3},]
    repo = InvoiceItemRepository.new(hashes, sales_engine)

    first_created_at = repo.find_by_created_at(Date.parse(date2))

    assert_equal [2], [first_created_at.id]

    second_created_at = repo.find_by_created_at(Date.parse(date3))
    assert_equal [3], [second_created_at.id]

    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]

  end

  def test_it_finds_the_first_example_of_invoice_item_by_updated_at
    sales_engine = "MY ENGINE"

    date1 = "Tue, 20 Mar 2012"
    date2 = "Tue, 19 Mar 2012"
    date3 = "Tue, 18 Mar 2012"

    hashes = [
        {id: 1, updated_at: date1},
        {id: 2, updated_at: date2},
        {id: 3, updated_at: date3},]
    repo = InvoiceItemRepository.new(hashes, sales_engine)

    first_updated_at = repo.find_by_updated_at(Date.parse(date1))

    assert_equal [1], [first_updated_at.id]

    second_updated_at = repo.find_by_updated_at(Date.parse(date2))
    assert_equal [2], [second_updated_at.id]

    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]
  end

  def test_it_creates_a_new_invoice_item
    sales_engine = SalesEngine.new

    sales_engine.create_item_repository([
                                            {id: 10001, unit_price: 7700},
                                            {id: 10002, unit_price: 7800},
                                            {id: 10003, unit_price: 7900},
                                            {id: 10004, unit_price: 8000},
                                            {id: 10005, unit_price: 8100},
                                        ])

    invoice_item_repository = sales_engine.create_invoice_item_repository([
                                                                              {id: 1001, invoice_id: 101, item_id: 10001, quantity: 1},
                                                                              {id: 1002, invoice_id: 102, item_id: 10002, quantity: 2},
                                                                              {id: 1003, invoice_id: 103, item_id: 10003, quantity: 3},
                                                                              {id: 1004, invoice_id: 104, item_id: 10004, quantity: 2},
                                                                              {id: 1005, invoice_id: 105, item_id: 10005, quantity: 1},
                                                                          ])

    invoice_repository = sales_engine.create_invoice_repository([
                                                                    {id: 101, customer_id: 11, merchant_id: 1, status: "shipped"},
                                                                    {id: 102, customer_id: 12, merchant_id: 2, status: "shipped"},
                                                                    {id: 103, customer_id: 13, merchant_id: 3, status: "shipped"},
                                                                    {id: 104, customer_id: 14, merchant_id: 4, status: "shipped"},
                                                                    {id: 105, customer_id: 15, merchant_id: 5, status: "shipped"},
                                                                    {id: 106, customer_id: 16, merchant_id: 6, status: "shipped"},
                                                                ])

    invoice_id = sales_engine.invoice_repository.find_by_id(106)
    quantities = [[10001, 1], [10002, 1], [10003, 1]]

    invoice_items = invoice_item_repository.create_invoice_items(
        invoice_id, quantities)

    assert_equal [1006, 1007, 1008], invoice_items.map {|invoice_item| invoice_item.id}
  end

end
