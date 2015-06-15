require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchant_repository

  def setup
      @merchant_repository = MerchantRepository.new
  end

  def test_it_exist
    assert merchant_repository
  end

  def test_the_repository_it_empty_to_start
    assert_equal 0, merchant_repository.repository.count
  end

  def test_the_repository_count_goes_up_by_one_when_you_add_an_instance_of_a_merchant
    merchant = Merchant.new(1, "Jack", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC")
    merchant_repository << merchant
    assert_equal 1, merchant_repository.repository.count
  end
end