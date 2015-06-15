class MerchantRepository
  attr_reader :repository

  def initialize
    @repository = []
  end

  def <<(merchant)
    repository << merchant
  end
end