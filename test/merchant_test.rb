require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test
  attr_reader :merchant

  def setup
    @merchant = Merchant.new(1, "Jack", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC")
  end

  def test_it_exists
    assert Merchant.new(1, "Jack", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC")
  end

  def test_it_has_an_id
    assert_equal 1, merchant.id
  end

  def test_it_has_a_name
    assert_equal "Jack", merchant.name
  end


end

