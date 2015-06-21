require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test

  def test_it_finds_the_first_transaction_by_id
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1},
        {id: 2},
        {id: 3},]
    repo = TransactionRepository.new(hashes, sales_engine)

    first_transactions = repo.find_by_id(1)
    assert_equal [1], [first_transactions.id]

    second_transactions = repo.find_by_id(2)
    assert_equal [2], [second_transactions.id]

  end

  def test_it_finds_the_first_transaction_by_invoice_id
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, invoice_id: 1},
        {id: 2, invoice_id: 2},
        {id: 3, invoice_id: 1},]
    repo = TransactionRepository.new(hashes, sales_engine)

    first_transactions = repo.find_by_invoice_id(1)

    assert_equal [1], [first_transactions.id]

    second_transactions = repo.find_by_invoice_id(2)
    assert_equal [2], [second_transactions.id]

  end

  def test_it_finds_the_first_transaction_by_credit_card_number
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, credit_card_number: 5},
        {id: 2, credit_card_number: 6},
        {id: 3, credit_card_number: 5},]
    repo = TransactionRepository.new(hashes, sales_engine)

    first_transactions = repo.find_by_credit_card_number(5)

    assert_equal [1], [first_transactions.id]

    second_transactions = repo.find_by_credit_card_number(6)
    assert_equal [2], [second_transactions.id]

  end

  def test_it_finds_the_first_transaction_by_credit_card_expiration_date
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, credit_card_expiration_date: 13635},
        {id: 2, credit_card_expiration_date: 34873},
        {id: 3, credit_card_expiration_date: 13635},]
    repo = TransactionRepository.new(hashes, sales_engine)

    first_transactions = repo.find_by_credit_card_expiration_date(13635)

    assert_equal [1], [first_transactions.id]

    second_transactions = repo.find_by_credit_card_expiration_date(34873)
    assert_equal [2], [second_transactions.id]

  end

  def test_it_finds_the_first_transaction_by_result
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, result: "success"},
        {id: 2, result: "not success"},
        {id: 3, result: "success"},]
    repo = TransactionRepository.new(hashes, sales_engine)

    first_transaction = repo.find_by_result("success")

    assert_equal [1], [first_transaction.id]

    second_transaction = repo.find_by_result("not success")
    assert_equal [2], [second_transaction.id]

    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]

  end

  def test_it_finds_the_first_transaction_by_created_at
    sales_engine = "MY ENGINE"

    time3 = Time.new - 3
    time5 = Time.new - 5
    time7 = Time.new - 7

    hashes = [
        {id: 1, created_at: (time3)},
        {id: 2, created_at: (time5)},
        {id: 3, created_at: (time7)},]
    repo = TransactionRepository.new(hashes, sales_engine)

    first_created_at = repo.find_by_created_at(time5)

    assert_equal [2], [first_created_at.id]

    second_created_at = repo.find_by_created_at(time7)
    assert_equal [3], [second_created_at.id]

    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]

  end

  def test_it_finds_the_first_transaction_by_updated_at
    sales_engine = "MY ENGINE"

    time3 = Time.new - 3
    time5 = Time.new - 5
    time7 = Time.new - 7

    hashes = [
        {id: 1, updated_at: time3},
        {id: 2, updated_at: time5},
        {id: 3, updated_at: time7},]
    repo = TransactionRepository.new(hashes, sales_engine)

    first_updated_at = repo.find_by_updated_at(time3)

    assert_equal [1], [first_updated_at.id]

    second_updated_at = repo.find_by_updated_at(time5)
    assert_equal [2], [second_updated_at.id]

    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]
  end

  def test_it_finds_all_transactions_by_id
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, invoice_id: 500},
        {id: 2, invoice_id: 555},
        {id: 1, invoice_id: 600}]
    repo = TransactionRepository.new(hashes, sales_engine)

    hundreds = repo.find_all_by_id(1)
    five_five_five = repo.find_all_by_id(2)

    assert_equal [500, 600], hundreds.map { |five_hundred| five_hundred.invoice_id }
    assert_equal [555], five_five_five.map { |five_twenty| five_twenty.invoice_id }
  end


  def test_it_finds_all_transactions_by_invoice_id
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, invoice_id: 1},
        {id: 2, invoice_id: 2},
        {id: 3, invoice_id: 1},]
    repo = TransactionRepository.new(hashes, sales_engine)

    invoice_ones = repo.find_all_by_invoice_id(1)
    invoice_twos = repo.find_all_by_invoice_id(2)
    invoice_threes = repo.find_all_by_invoice_id(3)

    assert_equal [1, 3], invoice_ones.map { |invoice_one| invoice_one.id }
    assert_equal [2], invoice_twos.map { |invoice_two| invoice_two.id }
    assert_equal [], invoice_threes.map { |invoice_three| invoice_three.id }
  end


  def test_it_finds_all_transactions_by_credit_card_number
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, credit_card_number: 5},
        {id: 2, credit_card_number: 6},
        {id: 3, credit_card_number: 5},]
    repo = TransactionRepository.new(hashes, sales_engine)

    invoice_fives = repo.find_all_by_credit_card_number(5)
    invoice_sixes = repo.find_all_by_credit_card_number(6)
    invoice_sevens = repo.find_all_by_credit_card_number(7)

    assert_equal [1, 3], invoice_fives.map { |invoice_five| invoice_five.id }
    assert_equal [2], invoice_sixes.map { |invoice_six| invoice_six.id }
    assert_equal [], invoice_sevens.map { |invoice_seven| invoice_seven.id }
  end

  def test_it_finds_all_transactions_by_credit_card_expiration_date
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, credit_card_expiration_date: 13635},
        {id: 2, credit_card_expiration_date: 34873},
        {id: 3, credit_card_expiration_date: 13635},]
    repo = TransactionRepository.new(hashes, sales_engine)

    invoice_thirteen_ks = repo.find_all_by_credit_card_expiration_date(13635)
    invoice_thirty_ks = repo.find_all_by_credit_card_expiration_date(34873)
    invoice_fifteen_ks = repo.find_all_by_credit_card_expiration_date(15000)

    assert_equal [1, 3], invoice_thirteen_ks.map { |invoice_thirteen_k| invoice_thirteen_k.id }
    assert_equal [2], invoice_thirty_ks.map { |invoice_thirty_k| invoice_thirty_k.id }
    assert_equal [], invoice_fifteen_ks.map { |invoice_fifteen_k| invoice_fifteen_k.id }
  end

  def test_it_finds_all_transactions_by_result
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, result: 5},
        {id: 2, result: 6},
        {id: 3, result: 5},]
    repo = TransactionRepository.new(hashes, sales_engine)

    invoice_fives = repo.find_all_by_result(5)
    invoice_sixes = repo.find_all_by_result(6)
    invoice_sevens = repo.find_all_by_result(7)

    assert_equal [1, 3], invoice_fives.map { |invoice_five| invoice_five.id }
    assert_equal [2], invoice_sixes.map { |invoice_six| invoice_six.id }
    assert_equal [], invoice_sevens.map { |invoice_seven| invoice_seven.id }
  end

  def test_it_finds_all_transactions_by_created_at

    time3 = Time.new - 3
    time5 = Time.new - 5
    time7 = Time.new - 7

    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, created_at: (time3)},
        {id: 2, created_at: (time5)},
        {id: 3, created_at: (time7)},
        {id: 5, created_at: (time7)},]

    repo = TransactionRepository.new(hashes, sales_engine)

    first_all_created_at = repo.find_all_by_created_at(time7)

    assert_equal [3, 5], first_all_created_at.map { |item| item.id}

    second_created_at = repo.find_all_by_created_at(time5)
    assert_equal [2], second_created_at.map { |item| item.id}

    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]

  end

  def test_it_finds_all_transactions_by_updated_at

    time3 = Time.new - 3
    time5 = Time.new - 5
    time7 = Time.new - 7

    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, updated_at: time3},
        {id: 2, updated_at: time5},
        {id: 3, updated_at: time7},]
    repo = TransactionRepository.new(hashes, sales_engine)

    first_updated_at = repo.find_by_updated_at(time3)

    assert_equal [1], [first_updated_at.id]

    second_updated_at = repo.find_by_updated_at(time5)
    assert_equal [2], [second_updated_at.id]

    # tv = repo.find_item_by_name("TV")
    # assert_equal [], [tv.id]

  end

  def test_it_returns_a_random_instance_transactions
    sales_engine = "MY ENGINE"
    hashes = [
        {id: 1, name: "Widget"},
        {id: 2, name: "Dongle"},
        {id: 3, name: "Widget"},]
    repo = TransactionRepository.new(hashes, sales_engine)

    assert repo.random

  end





end
