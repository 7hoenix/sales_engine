require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_repository'
require_relative '../lib/item_repository'
require_relative '../lib/invoice'

class InvoiceRepositoryTest < Minitest::Test
    def test_it_finds_the_first_example_of_invoice_by_customer_id
      sales_engine = "MY ENGINE"
      hashes = [
          {id: 1, customer_id: 5},
          {id: 2, customer_id: 6},
          {id: 3, customer_id: 5},]
      repo = InvoiceRepository.new(hashes, sales_engine)

      first_invoice = repo.find_by_customer_id(5)

      assert_equal [1], [first_invoice.id]

      second_invoice = repo.find_by_customer_id(6)
      assert_equal [2], [second_invoice.id]

      # tv = repo.find_item_by_name("TV")
      # assert_equal [], [tv.id]

    end

    def test_it_finds_all_examples_of_invoice_by_customer_id
      sales_engine = "MY ENGINE"
      hashes = [
          {id: 1, customer_id: 5},
          {id: 2, customer_id: 6},
          {id: 3, customer_id: 5},]
      repo = InvoiceRepository.new(hashes, sales_engine)

      invoices = repo.find_all_by_customer_id(5)

      assert_equal [1,3], invoices.map { |invoice| invoice.id }

      second_invoice = repo.find_all_by_customer_id(6)
      assert_equal [2], second_invoice.map { |invoice| invoice.id }

      # tv = repo.find_item_by_name("TV")
      # assert_equal [], [tv.id]

    end

    def test_it_finds_the_first_example_of_invoice_by_merchant_id
      sales_engine = "MY ENGINE"
      hashes = [
          {id: 1, merchant_id: 5},
          {id: 2, merchant_id: 6},
          {id: 3, merchant_id: 5},]
      repo = InvoiceRepository.new(hashes, sales_engine)

      first_invoice = repo.find_by_merchant_id(5)

      assert_equal [1], [first_invoice.id]

      second_invoice = repo.find_by_merchant_id(6)
      assert_equal [2], [second_invoice.id]

      # tv = repo.find_item_by_name("TV")
      # assert_equal [], [tv.id]

    end

    def test_it_finds_all_examples_of_invoice_by_merchant_id
      sales_engine = "MY ENGINE"
      hashes = [
          {id: 1, merchant_id: 5},
          {id: 2, merchant_id: 6},
          {id: 3, merchant_id: 5},]
      repo = InvoiceRepository.new(hashes, sales_engine)

      fives = repo.find_all_by_merchant_id(5)

      assert_equal [1, 3], fives.map { |invoice| invoice.id }

      second_invoice = repo.find_all_by_merchant_id(6)
      assert_equal [2], second_invoice.map { |invoice| invoice.id }

      # tv = repo.find_item_by_name("TV")
      # assert_equal [], [tv.id]

    end


    def test_it_finds_the_first_example_of_invoice_by_status
      sales_engine = "MY ENGINE"
      hashes = [
          {id: 1, status: "shipped"},
          {id: 2, status: "not shipped"},
          {id: 3, status: "shipped"},]
      repo = InvoiceRepository.new(hashes, sales_engine)

      first_invoice = repo.find_by_status("shipped")

      assert_equal [1], [first_invoice.id]

      second_invoice = repo.find_by_status("not shipped")
      assert_equal [2], [second_invoice.id]

      # tv = repo.find_item_by_name("TV")
      # assert_equal [], [tv.id]

    end

    def test_it_finds_all_examples_of_invoice_by_status
      sales_engine = "MY ENGINE"
      hashes = [
          {id: 1, status: "shipped"},
          {id: 2, status: "not shipped"},
          {id: 3, status: "shipped"},]
      repo = InvoiceRepository.new(hashes, sales_engine)

      invoices = repo.find_all_by_status("shipped")

      assert_equal [1, 3], invoices.map { |invoice| invoice.id }

      second_invoice = repo.find_all_by_status("not shipped")
      assert_equal [2], second_invoice.map { |invoice| invoice.id }

      # tv = repo.find_item_by_name("TV")
      # assert_equal [], [tv.id]

    end

    def test_it_finds_the_first_example_of_item_by_created_at

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

    def test_it_finds_the_first_example_of_item_by_updated_at

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

    def test_it_finds_all_examples_of_items_by_description

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

    def test_it_finds_all_examples_of_items_by_unit_price

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

    def test_it_finds_all_examples_of_items_by_merchant_id

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

end
