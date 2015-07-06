require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_repository'
require_relative '../lib/item_repository'
require_relative '../lib/invoice'

class InvoiceRepositoryTest < Minitest::Test

  def test_it_finds_the_first_invoice_by_id
      sales_engine = "MY ENGINE"
      hashes = [
          {id: 1, customer_id: 5},
          {id: 2, customer_id: 6},
          {id: 3, customer_id: 5},]
      repo = InvoiceRepository.new(hashes, sales_engine)

      first_invoice = repo.find_by_id(1)

      assert_equal [5], [first_invoice.customer_id]

      second_invoice = repo.find_by_id(2)
      assert_equal [6], [second_invoice.customer_id]

      # tv = repo.find_item_by_name("TV")
      # assert_equal [], [tv.id]

  end

def test_it_finds_the_first_invoice_by_customer_id
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

  def test_it_finds_the_first_invoice_by_merchant_id
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

  def test_it_finds_the_first_invoice_by_status
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

    #s tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]

  end

  def test_it_finds_the_first_invoice_by_created_at

    date1 = "Tue, 20 Mar 2012"
    date2 = "Tue, 19 Mar 2012"
    date3 = "Tue, 18 Mar 2012"


    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, created_at: (date1)},
        {id: 2, created_at: (date2)},
        {id: 3, created_at: (date3)},]
    repo = InvoiceRepository.new(hashes, sales_engine)

    first_created_at = repo.find_by_created_at(Date.parse(date2))

    assert_equal [2], [first_created_at.id]

    second_created_at = repo.find_by_created_at(Date.parse(date3))
    assert_equal [3], [second_created_at.id]

    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]

  end

  def test_it_finds_the_first_invoice_by_updated_at

    date1 = "Tue, 20 Mar 2012"
    date2 = "Tue, 19 Mar 2012"
    date3 = "Tue, 18 Mar 2012"

    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, updated_at: date1},
        {id: 2, updated_at: date2},
        {id: 3, updated_at: date3},]
    repo = InvoiceRepository.new(hashes, sales_engine)

    first_updated_at = repo.find_by_updated_at(Date.parse(date1))

    assert_equal [1], [first_updated_at.id]

    second_updated_at = repo.find_by_updated_at(Date.parse(date2))
    assert_equal [2], [second_updated_at.id]

    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]

  end

  def test_it_finds_all_invoices_by_id
      sales_engine = "MY ENGINE"

      hashes = [
          {id: 1, customer_id: 5},
          {id: 2, customer_id: 6},
          {id: 2, customer_id: 8},
          {id: 1, customer_id: 7}]

      repo = InvoiceRepository.new(hashes, sales_engine)

      invoices = repo.find_all_by_id(1)

      assert_equal [5,7], invoices.map { |invoice| invoice.customer_id }

      second_invoice = repo.find_all_by_id(2)

      assert_equal [6, 8], second_invoice.map { |invoice| invoice.customer_id }

      # tv = repo.find_item_by_name("TV")
      # assert_equal [], [tv.id]

    end

def test_it_finds_all_invoices_by_customer_id
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


  def test_it_finds_all_invoices_by_merchant_id
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

  def test_it_finds_all_invoices_by_status
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

  def test_it_finds_all_invoices_by_created_at

    date1 = "Tue, 20 Mar 2012"
    date2 = "Tue, 19 Mar 2012"
    date3 = "Tue, 18 Mar 2012"

    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, created_at: (date1)},
        {id: 2, created_at: (date2)},
        {id: 3, created_at: (date3)},
        {id: 5, created_at: (date3)},]

    repo = InvoiceRepository.new(hashes, sales_engine)

    first_all_created_at = repo.find_all_by_created_at(Date.parse(date3))

    assert_equal [3, 5], first_all_created_at.map { |invoice| invoice.id}

    second_created_at = repo.find_all_by_created_at(Date.parse(date2))
    assert_equal [2], second_created_at.map { |invoice| invoice.id}

    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]

  end

  def test_it_finds_all_invoices_by_updated_at

    date1 = "Tue, 20 Mar 2012"
    date2 = "Tue, 19 Mar 2012"
    date3 = "Tue, 18 Mar 2012"

    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, updated_at: date1},
        {id: 2, updated_at: date2},
        {id: 3, updated_at: date3},]
    repo = InvoiceRepository.new(hashes, sales_engine)

    first_updated_at = repo.find_by_updated_at(Date.parse(date1))

    assert_equal [1], [first_updated_at.id]

    second_updated_at = repo.find_by_updated_at(Date.parse(date2))
    assert_equal [2], [second_updated_at.id]

    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]

  end

  def test_it_creates_a_new_invoice_given_the_necessary_inputs_from_other_classes

    sales_engine = SalesEngine.new

    customer_repository = sales_engine.create_customer_repository([
                                                {id: 11},
                                                {id: 12},
                                            ])

    merchant_repository = sales_engine.create_merchant_repository([
                                                                      {id: 1},
                                                                      {id: 2},
                                                                      {id: 3},
                                                                  ])

    sales_engine.create_invoice_item_repository([
                                                    {id: 1001, invoice_id: 101, item_id: 10001},
                                                    {id: 1002, invoice_id: 102, item_id: 10002},
                                                    {id: 1003, invoice_id: 103, item_id: 10003},
                                                    {id: 1004, invoice_id: 104, item_id: 10004},
                                                    {id: 1005, invoice_id: 105, item_id: 10005},
                                                ])
    item_repository = sales_engine.create_item_repository([
                                            {id: 10001, merchant_id: 1, unit_price: 7700},
                                            {id: 10002, merchant_id: 2, unit_price: 7800},
                                            {id: 10003, merchant_id: 3, unit_price: 7900},
                                            {id: 10004, merchant_id: 2, unit_price: 8000},
                                            {id: 10005, merchant_id: 1, unit_price: 8100},
                                        ])
    invoice_repository = sales_engine.create_invoice_repository([
                                        {id: 101, customer_id: 11, merchant_id: 1, status: "shipped"},
                                        {id: 102, customer_id: 12, merchant_id: 2, status: "shipped"},
                                        {id: 103, customer_id: 13, merchant_id: 3, status: "shipped"},
                                        {id: 104, customer_id: 14, merchant_id: 4, status: "shipped"},
                                        {id: 105, customer_id: 15, merchant_id: 5, status: "shipped"},
                                    ])
    current_customer = customer_repository.find_by_id(11)
    current_merchant = merchant_repository.find_by_id(2)

    item1 = item_repository.find_by_id(10001)
    item2 = item_repository.find_by_id(10002)
    item3 = item_repository.find_by_id(10003)

    invoice = invoice_repository.create(customer: current_customer, merchant: current_merchant, status: "shipped",
    items: [item1, item2, item3])

    assert_equal 106, invoice_repository.all.last.id

  end

end
