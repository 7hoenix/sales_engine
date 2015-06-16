class Invoice

  attr_reader :created_at, :updated_at, :merchant_id, :customer_id, :id, :status

  def initialize(id, customer_id, merchant_id, status, created_at, updated_at)
    @id = id
    @customer_id = customer_id
    @merchant_id = merchant_id
    @status = status
    @created_at = created_at
    @updated_at = updated_at
  end

end