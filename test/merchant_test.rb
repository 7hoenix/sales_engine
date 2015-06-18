require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test
  def test_it_has_a_name
    merchant_data = {id: 1, name: "Walmart"}
    merchant_repository = "MERCHANT REPOSITORY"
    merchant = Merchant.new(merchant_data, merchant_repository)

    assert_equal "Walmart", merchant.name
  end
end

