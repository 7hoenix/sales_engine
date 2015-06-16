class MerchantRepository
  attr_reader :repository

  def initialize
    @repository = []
  end

  def <<(merchant)
    repository << [merchant.id, merchant.name, merchant.created_at, merchant.updated_at]
  end

  def all
    repository.collect { |merchant| merchant }
  end

  def random
    repository.shuffle.first
  end

  def find_by_id(id)
    repository.find { |merchant| merchant[0] == id }
  end

  def find_by_name(name)
    repository.find { |merchant| merchant[1] == name }
  end

  def find_by_created_at(created_at)
    repository.find { |merchant| merchant[2] == created_at }
  end

  def find_by_updated_at(updated_at)
    repository.find { |merchant| merchant[3] == updated_at }
  end

  def find_all_by_id(id)
    repository.select { |merchant| merchant[0] == id }
  end

  def find_all_by_name(name)
    repository.select { |merchant| merchant[1] == name }
  end

  def find_all_by_created_at(created_at)
    repository.select { |merchant| merchant[2] == created_at }
  end

  def find_all_by_updated_at(updated_at)
    repository.select { |merchant| merchant[3] == updated_at }
  end
end
