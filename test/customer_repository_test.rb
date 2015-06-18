require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  def test_it_finds_the_first_example_of_customer_by_first_name
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, first_name: "Justin"},
        {id: 2, first_name: "Mike"},
        {id: 3, first_name: "Justin"},]
    repo = CustomerRepository.new(hashes, sales_engine)

    first_customer = repo.find_customer_by_first_name("Justin")

    assert_equal [1], [first_customer.id]

    second_customer = repo.find_customer_by_first_name("Mike")
    assert_equal [2], [second_customer.id]

    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]

  end

  def test_it_finds_all_examples_of_customers_by_first_name
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, first_name: "Justin"},
        {id: 2, first_name: "Mike"},
        {id: 3, first_name: "Justin"},]
    repo = CustomerRepository.new(hashes, sales_engine)

    justins = repo.find_all_customers_by_first_name("Justin")
    mikes = repo.find_all_customers_by_first_name("Mike")
    sams = repo.find_all_customers_by_first_name("Sam")

    assert_equal [1, 3], justins.map { |justin| justin.id }
    assert_equal [2], mikes.map { |mike| mike.id }
    assert_equal [], sams.map { |sam| sam.id }
  end

  def test_it_finds_the_first_example_of_customer_by_last_name
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, last_name: "Clark"},
        {id: 2, last_name: "Taylor"},
        {id: 3, last_name: "Clark"},]
    repo = CustomerRepository.new(hashes, sales_engine)

    first_customer = repo.find_customer_by_last_name("Clark")

    assert_equal [1], [first_customer.id]

    second_customer = repo.find_customer_by_last_name("Taylor")
    assert_equal [2], [second_customer.id]

  end

  def test_it_finds_all_examples_of_customers_by_last_name
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, last_name: "Clark"},
        {id: 2, last_name: "Taylor"},
        {id: 3, last_name: "Clark"},]
    repo = CustomerRepository.new(hashes, sales_engine)

    clarks = repo.find_all_customers_by_last_name("Clark")
    taylors = repo.find_all_customers_by_last_name("Taylor")
    holzmanns = repo.find_all_customers_by_last_name("Holzmann")

    assert_equal [1, 3], clarks.map { |clark| clark.id }
    assert_equal [2], taylors.map { |taylor| taylor.id }
    assert_equal [], holzmanns.map { |holzmann| holzmann.id }
  end

  def test_it_returns_a_random_instance_of_customer
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, first_name: "Justin"},
        {id: 2, first_name: "Mike"},
        {id: 3, first_name: "Justin"},]
    repo = CustomerRepository.new(hashes, sales_engine)

    assert repo.random

  end

  def test_it_finds_the_first_example_of_item_by_created_at
    skip
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, created_at: (Time.now - 3)},
        {id: 2, created_at: (Time.now - 5)},
        {id: 3, created_at: (Time.now - 7)},]
    repo = CustomerRepository.new(hashes, sales_engine)

    first_created_at = repo.find_customer_by_created_at(Time.now - 5)

    assert_equal [2], [first_created_at.id]

    second_created_at = repo.find_customer_by_created_at(Time.now - 7)
    assert_equal [3], [second_created_at.id]

  end

  def test_it_finds_the_first_example_of_customer_by_updated_at
    skip
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, updated_at: Time.now - 3},
        {id: 1, updated_at: Time.now - 5},
        {id: 1, updated_at: Time.now - 7},]
    repo = CustomerRepository.new(hashes, sales_engine)

    first_updated_at = repo.find_customer_by_updated_at(Time.now - 3)

    assert_equal [1], [first_updated_at.id]

    second_updated_at = repo.find_customer_by_updated_at(Time.now - 5)
    assert_equal [2], [second_updated_at.id]

  end


end
