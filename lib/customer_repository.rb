class CustomerRepository
  attr_reader :customer_data, :sales_engine, :customers

  def initialize(customer_data, sales_engine)
    @customer_data = customer_data
    @sales_engine = sales_engine
    @customers = []
    load_up_data
  end

  def load_up_data
    customer_data.each do |customer|
      customers << Customer.new(customer, self)
    end
  end

  def all
    customers.collect { |customer| customer }
  end

  def random
    customers.shuffle.first
  end

  def find_customer_by_id(id)
    customers.find { |customer| customer.id == id }
  end

  def find_by_first_name(first_name)
    customers.find { |customer| customer.first_name == first_name }
  end

  def find_by_last_name(last_name)
    customers.find { |customer| customer.last_name == last_name }
  end

  def find_by_created_at(created_at)
    customers.find { |customer| customer.created_at == created_at }
  end

  def find_by_updated_at(updated_at)
    customers.find { |customer| customer.updated_at == updated_at }
  end

  def find_all_by_id(id)
    customers.select { |customer| customer.id == id }
  end

  def find_all_by_first_name(first_name)
    customers.select { |customer| customer.first_name == first_name }
  end

  def find_all_by_last_name(last_name)
    customers.select { |customer| customer.last_name == last_name }
  end

  def find_all_by_created_at(created_at)
    customers.select { |customer| customer.created_at == created_at }
  end

  def find_all_by_updated_at(updated_at)
    customers.select { |customer| customer.updated_at == updated_at }
  end

  # spec harness
  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end

end
