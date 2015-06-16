require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'

class InvoiceRepositoryTest < Minitest::Test
  attr_reader :invoice_repository

  def setup
    @invoice_repository = InvoiceRepository.new

    invoice = Invoice.new(1,1,26,"shipped","2012-03-25 09:54:09 UTC","2012-03-25 09:54:09 UTC")
    invoice2 = Invoice.new(2,1,75,"shipped","2012-03-12 05:54:09 UTC","2012-03-12 05:54:09 UTC")
    invoice3 = Invoice.new(3,1,78,"shipped","2012-03-10 00:54:09 UTC","2012-03-10 00:54:09 UTC")

    invoice_repository << invoice
    invoice_repository << invoice2
    invoice_repository << invoice3
  end

  def test_it_exist
    assert invoice_repository
  end

  def test_the_repository_count_goes_up_by_three_when_you_add_three_instances_of_a_merchant
    assert_equal 3, invoice_repository.repository.count
  end

  def test_it_returns_all_instances_when_the_all_method_is_called

    all_invoices = invoice_repository.all

    expected = [[1, 1, 26, "shipped", "2012-03-25 09:54:09 UTC", "2012-03-25 09:54:09 UTC"], [2,1,75,"shipped","2012-03-12 05:54:09 UTC","2012-03-12 05:54:09 UTC"], [3,1,78,"shipped","2012-03-10 00:54:09 UTC","2012-03-10 00:54:09 UTC"]]
    assert_equal expected, all_invoices
  end

  def test_it_returns_a_random_instance_when_the_random_method_is_called
    skip
    # figure out how to stub so we can actually test this
    invoice = Invoice.new(1, 1, 26, "shipped", "2012-03-25 09:54:09 UTC", "2012-03-25 09:54:09 UTC")
    invoice2 = Invoice.new(2,1,75,"shipped","2012-03-12 05:54:09 UTC","2012-03-12 05:54:09 UTC")
    invoice_repository << invoice
    invoice_repository << invoice2

    random_invoice = invoice_repository.random

    expected = [1, 1, 26, "shipped", "2012-03-25 09:54:09 UTC", "2012-03-25 09:54:09 UTC"]
    assert_equal expected, random_invoice
  end

  def test_it_finds_an_instance_of_invoice_by_searching_for_id
    id = 2

    invoice_by_id = invoice_repository.find_by_id(id)

    expected = [2,1,75,"shipped","2012-03-12 05:54:09 UTC","2012-03-12 05:54:09 UTC"]

    assert_equal expected, invoice_by_id
  end

  def test_it_finds_an_instance_of_invoice_by_searching_for_customer_id
    customer_id = 1

    invoice_by_customer_id = invoice_repository.find_by_customer_id(customer_id)

    expected = [1, 1, 26, "shipped", "2012-03-25 09:54:09 UTC", "2012-03-25 09:54:09 UTC"]

    assert_equal expected, invoice_by_customer_id
  end

  def test_it_finds_an_instance_of_invoice_by_searching_for_merchant_id
    merchant_id = 75

    invoice_by_merchant_id = invoice_repository.find_by_merchant_id(merchant_id)

    expected = [2,1,75,"shipped","2012-03-12 05:54:09 UTC","2012-03-12 05:54:09 UTC"]

    assert_equal expected, invoice_by_merchant_id
  end

  def test_it_finds_an_instance_of_invoice_by_searching_for_status
    status = "shipped"

    invoice_by_status = invoice_repository.find_by_status(status)

    expected = [1, 1, 26, "shipped", "2012-03-25 09:54:09 UTC", "2012-03-25 09:54:09 UTC"]

    assert_equal expected, invoice_by_status
  end

  def test_it_finds_an_instance_of_invoice_by_searching_for_created_at
    created_at = "2012-03-12 05:54:09 UTC"

    invoice_by_created_at = invoice_repository.find_by_created_at(created_at)

    expected = [2,1,75,"shipped","2012-03-12 05:54:09 UTC","2012-03-12 05:54:09 UTC"]

    assert_equal expected, invoice_by_created_at
  end

  def test_it_finds_an_instance_of_invoice_by_searching_for_updated_at
    updated_at = "2012-03-12 05:54:09 UTC"

    invoice_by_updated_at = invoice_repository.find_by_updated_at(updated_at)

    expected = [2,1,75,"shipped","2012-03-12 05:54:09 UTC","2012-03-12 05:54:09 UTC"]

    assert_equal expected, invoice_by_updated_at
  end

  def test_it_finds_all_instances_of_invoice_by_searching_for_id
    invoice4 = Invoice.new(2,18,77,"not shipped","2012-03-12 05:54:09 UTC","2012-03-12 05:54:09 UTC")
    invoice_repository << invoice4

    id = 2

    all_invoices_by_id = invoice_repository.find_all_by_id(id)

    expected = [[2,1,75,"shipped","2012-03-12 05:54:09 UTC","2012-03-12 05:54:09 UTC"],[2,18,77,"not shipped","2012-03-12 05:54:09 UTC","2012-03-12 05:54:09 UTC"]]

    assert_equal expected, all_invoices_by_id
  end

  def test_it_finds_all_instances_of_invoice_by_searching_for_customer_id
    customer_id = 1

    all_invoices_by_customer_id = invoice_repository.find_all_by_customer_id(customer_id)

    expected = [[1,1,26,"shipped","2012-03-25 09:54:09 UTC","2012-03-25 09:54:09 UTC"],[2,1,75,"shipped","2012-03-12 05:54:09 UTC","2012-03-12 05:54:09 UTC"],[3,1,78,"shipped","2012-03-10 00:54:09 UTC","2012-03-10 00:54:09 UTC"]]

    assert_equal expected, all_invoices_by_customer_id
  end

  def test_it_finds_all_instances_of_invoice_by_searching_for_merchant_id
    invoice4 = Invoice.new(2,1,26,"shipped","2012-03-12 05:54:09 UTC","2012-03-12 05:54:09 UTC")
    invoice5 = Invoice.new(3,1,26,"shipped","2012-03-10 00:54:09 UTC","2012-03-10 00:54:09 UTC")

    invoice_repository << invoice4
    invoice_repository << invoice5

    merchant_id = 26

    all_invoices_by_merchant_id = invoice_repository.find_all_by_merchant_id(merchant_id)

    expected = [[1,1,26,"shipped","2012-03-25 09:54:09 UTC","2012-03-25 09:54:09 UTC"],[2,1,26,"shipped","2012-03-12 05:54:09 UTC","2012-03-12 05:54:09 UTC"],[3,1,26,"shipped","2012-03-10 00:54:09 UTC","2012-03-10 00:54:09 UTC"]]

    assert_equal expected, all_invoices_by_merchant_id
  end

  def test_it_finds_all_instances_of_invoice_by_searching_for_status
    invoice4 = Invoice.new(2,1,26,"not shipped","2012-03-12 05:54:09 UTC","2012-03-12 05:54:09 UTC")
    invoice_repository << invoice4

    status = "not shipped"

    all_invoices_by_status = invoice_repository.find_all_by_status(status)

    expected = [[2,1,26,"not shipped","2012-03-12 05:54:09 UTC","2012-03-12 05:54:09 UTC"]]

    assert_equal expected, all_invoices_by_status
  end

  def test_it_finds_all_instances_of_invoice_by_searching_for_created_at
    invoice4 = Invoice.new(2,1,26,"shipped","2012-03-14 05:54:09 UTC","2012-03-12 05:54:09 UTC")
    invoice5 = Invoice.new(3,1,26,"shipped","2012-03-14 05:54:09 UTC","2012-03-10 00:54:09 UTC")

    invoice_repository << invoice4
    invoice_repository << invoice5

    created_at = "2012-03-14 05:54:09 UTC"

    all_invoices_by_created_at = invoice_repository.find_all_by_created_at(created_at)

    expected = [[2,1,26,"shipped","2012-03-14 05:54:09 UTC","2012-03-12 05:54:09 UTC"],[3,1,26,"shipped","2012-03-14 05:54:09 UTC","2012-03-10 00:54:09 UTC"]]

    assert_equal expected, all_invoices_by_created_at
  end

  def test_it_finds_all_instances_of_invoice_by_searching_for_updated_at
    invoice4 = Invoice.new(2,1,26,"shipped","2012-03-14 05:54:09 UTC","2012-03-14 05:54:09 UTC")
    invoice5 = Invoice.new(3,1,26,"shipped","2012-03-15 05:54:09 UTC","2012-03-14 05:54:09 UTC")

    invoice_repository << invoice4
    invoice_repository << invoice5

    updated_at = "2012-03-14 05:54:09 UTC"

    all_invoices_by_updated_at = invoice_repository.find_all_by_updated_at(updated_at)

    expected = [[2,1,26,"shipped","2012-03-14 05:54:09 UTC","2012-03-14 05:54:09 UTC"],[3,1,26,"shipped","2012-03-15 05:54:09 UTC","2012-03-14 05:54:09 UTC"]]

    assert_equal expected, all_invoices_by_updated_at
  end
end