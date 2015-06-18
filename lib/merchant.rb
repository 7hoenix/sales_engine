class Merchant
  attr_reader :merchant_data, :merchant_repository

  def initialize(merchant_data, merchant_repository)
    @merchant_data = merchant_data
    @merchant_repository = merchant_repository
  end


  def id
    merchant_data[:id]
  end

  def name
    merchant_data[:name]
  end

  def created_at
    merchant_data[:created_at]
  end

  def updated_at
    merchant_data[:updated_at]
  end
end

