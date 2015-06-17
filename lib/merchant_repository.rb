require 'pry'

class MerchantRepository
  attr_reader :engine, :merchant_data, :merchants

  def initialize(merchant_data, engine)
    @merchants = []
    @merchant_data = merchant_data
    @engine = engine
    load_up_data
  end

  def load_up_data
    merchant_data.each do |row|
      merchants << Merchant.new(row, self)
    end
  end

  def all
    merchants.collect { |merchant| [merchant.id, merchant.name, merchant.created_at, merchant.updated_at] }
  end

  def random
    merchants.shuffle.first
  end

  def find_by_id(id)
    merchants.find { |merchant| merchant[0] == id }
  end

  def find_by_name(name)
    merchants.find { |merchant| merchant[1] == name }
  end

  def find_by_created_at(created_at)
    merchants.find { |merchant| merchant[2] == created_at }
  end

  def find_by_updated_at(updated_at)
    merchants.find { |merchant| merchant[3] == updated_at }
  end

  def find_all_by_id(id)
    merchants.select { |merchant| merchant[0] == id }
  end

  def find_all_by_name(name)
    merchants.select { |merchant| merchant[1] == name }
  end

  def find_all_by_created_at(created_at)
    merchants.select { |merchant| merchant[2] == created_at }
  end

  def find_all_by_updated_at(updated_at)
    merchants.select { |merchant| merchant[3] == updated_at }
  end
end

# e = SalesEngine.new
# mr = MerchantRepository.new([["1", "Schroeder-Jerde", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["2", "Klein, Rempel and Jones", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["3", "Willms and Sons", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["4", "Cummings-Thiel", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["5", "Williamson Group", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["6", "Williamson Group", "2012-03-27 14:53:59 UTC", "2012-03-27 16:12:25 UTC"], ["7", "Bernhard-Johns", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["8", "Osinski, Pollich and Koelpin", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["9", "Hand-Spencer", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["10", "Bechtelar, Jones and Stokes", "2012-03-27 14:54:00 UTC", "2012-03-27 14:54:00 UTC"]], e)
# puts mr.all
