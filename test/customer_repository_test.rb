require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer_repository'
require_relative '../lib/customer'

class CustomerRepositoryTest < Minitest::Test

  def test_it_returns_all_instances_of_customer
    sales_engine = "MY ENGINE"
    customer_data = [
        {id: 1},
        {id: 2},
        {id: 3},]
    customer_repository = CustomerRepository.new(customer_data, sales_engine)

    customers = customer_repository.all

    assert_equal [1, 2, 3], customers.map { |customer| customer.id }

    customer_data = [
        {id: 1},
        {id: 2},
        {id: 3},
        {id: 4},]
    customer_repository = CustomerRepository.new(customer_data, sales_engine)

    customers = customer_repository.all
    assert_equal [1, 2, 3, 4], customers.map { |customer| customer.id }

  end

  def test_it_finds_the_first_example_of_customer_by_first_name
    sales_engine = "MY ENGINE"
    customer_data = [
        {id: 1, first_name: "Justin"},
        {id: 2, first_name: "Mike"},
        {id: 3, first_name: "Justin"},]
    customer_repository = CustomerRepository.new(customer_data, sales_engine)

    first_customer = customer_repository.find_by_first_name("Justin")

    assert_equal [1], [first_customer.id]

    second_customer = customer_repository.find_by_first_name("Mike")
    assert_equal [2], [second_customer.id]

    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]

  end

  def test_it_finds_all_examples_of_customers_by_first_name
    sales_engine = "MY ENGINE"
    customer_data = [
        {id: 1, first_name: "Justin"},
        {id: 2, first_name: "Mike"},
        {id: 3, first_name: "Justin"},]
    customer_repository = CustomerRepository.new(customer_data, sales_engine)

    justins = customer_repository.find_all_by_first_name("Justin")
    mikes = customer_repository.find_all_by_first_name("Mike")
    sams = customer_repository.find_all_by_first_name("Sam")

    assert_equal [1, 3], justins.map { |justin| justin.id }
    assert_equal [2], mikes.map { |mike| mike.id }
    assert_equal [], sams.map { |sam| sam.id }
  end

  def test_it_finds_the_first_example_of_customer_by_last_name
    sales_engine = "MY ENGINE"
    customer_data = [
        {id: 1, last_name: "Clark"},
        {id: 2, last_name: "Taylor"},
        {id: 3, last_name: "Clark"},]
    customer_repository = CustomerRepository.new(customer_data, sales_engine)

    first_customer = customer_repository.find_by_last_name("Clark")

    assert_equal [1], [first_customer.id]

    second_customer = customer_repository.find_by_last_name("Taylor")
    assert_equal [2], [second_customer.id]

  end

  def test_it_finds_all_examples_of_customers_by_last_name
    sales_engine = "MY ENGINE"
    customer_data = [
        {id: 1, last_name: "Clark"},
        {id: 2, last_name: "Taylor"},
        {id: 3, last_name: "Clark"},]
    customer_repository = CustomerRepository.new(customer_data, sales_engine)

    clarks = customer_repository.find_all_by_last_name("Clark")
    taylors = customer_repository.find_all_by_last_name("Taylor")
    holzmanns = customer_repository.find_all_by_last_name("Holzmann")

    assert_equal [1, 3], clarks.map { |clark| clark.id }
    assert_equal [2], taylors.map { |taylor| taylor.id }
    assert_equal [], holzmanns.map { |holzmann| holzmann.id }
  end

  def test_it_returns_a_random_instance_of_customer
    sales_engine = "MY ENGINE"
    customer_data = [
        {id: 1, first_name: "Justin"},
        {id: 2, first_name: "Mike"},
        {id: 3, first_name: "Justin"},]
    customer_repository = CustomerRepository.new(customer_data, sales_engine)

    assert customer_repository.random

  end

  def test_it_finds_the_first_example_of_item_by_created_at
    sales_engine = "MY ENGINE"

    date1 = "Tue, 20 Mar 2012"
    date2 = "Tue, 19 Mar 2012"
    date3 = "Tue, 18 Mar 2012"

    customer_data = [
        {id: 1, created_at: date1},
        {id: 2, created_at: date2},
        {id: 3, created_at: date3},]
    customer_repository = CustomerRepository.new(customer_data, sales_engine)

    first_created_at = customer_repository.find_by_created_at(Date.parse(date2))

    assert_equal [2], [first_created_at.id]

    second_created_at = customer_repository.find_by_created_at(Date.parse(date3))
    assert_equal [3], [second_created_at.id]

  end

  def test_it_finds_the_first_example_of_customer_by_updated_at
    sales_engine = "MY ENGINE"

    date1 = "Tue, 20 Mar 2012"
    date2 = "Tue, 19 Mar 2012"
    date3 = "Tue, 18 Mar 2012"

    customer_data = [
        {id: 1, updated_at: date1},
        {id: 2, updated_at: date2},
        {id: 3, updated_at: date3},]
    customer_repository = CustomerRepository.new(customer_data, sales_engine)

    first_updated_at = customer_repository.find_by_updated_at(Date.parse(date1))

    assert_equal [1], [first_updated_at.id]

    second_updated_at = customer_repository.find_by_updated_at(Date.parse(date2))
    assert_equal [2], [second_updated_at.id]

  end

 def test_it_finds_all_examples_of_item_by_created_at
    sales_engine = "MY ENGINE"

    date1 = "Tue, 20 Mar 2012"
    date2 = "Tue, 19 Mar 2012"

    customer_data = [
        {id: 1, created_at: date1},
        {id: 2, created_at: date2},
        {id: 3, created_at: date1},]
    customer_repository = CustomerRepository.new(customer_data, sales_engine)

    customers = customer_repository.find_all_by_created_at(Date.parse(date2))

    assert_equal [2], customers.map { |customer| customer.id }

    customers = customer_repository.find_all_by_created_at(Date.parse(date1))
    assert_equal [1, 3], customers.map { |customer| customer.id }

  end

  def test_it_finds_all_examples_of_customer_by_updated_at
    sales_engine = "MY ENGINE"

    date1 = "Tue, 20 Mar 2012"
    date2 = "Tue, 19 Mar 2012"

    customer_data = [
        {id: 1, updated_at: date1},
        {id: 2, updated_at: date2},
        {id: 3, updated_at: date1},]
    customer_repository = CustomerRepository.new(customer_data, sales_engine)

    customers = customer_repository.find_all_by_updated_at(Date.parse(date2))

    assert_equal [2], customers.map { |customer| customer.id}

    customers = customer_repository.find_all_by_updated_at(Date.parse(date1))
    assert_equal [1, 3], customers.map { |customer| customer.id }

  end


end
