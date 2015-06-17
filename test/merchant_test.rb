require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'

class MerchantTest < Minitest::Test
  attr_reader :merchant

  def setup
    repository = "INSERT REPO HERE"
    sanitized_data = [1, "Jack", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"]
    @merchant = Merchant.new(sanitized_data, repository)
  end

  def test_it_exists
    assert @merchant
  end

  def test_it_has_an_id
    assert_equal 1, merchant.id
  end

  def test_it_has_a_name
    assert_equal "Jack", merchant.name
  end


end

