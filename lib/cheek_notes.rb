class TestCustomerRepository < Minitest::Test
  def test_it_finds_its_invoices
    # customers
    customer_repo = CustomerRepository.new([ {id: 10}, {id: 20}, {id: 30}])

  # invoices
    invoice_repo = InvoiceRepository.new([{id: 1, customer_id: 10}, {id: 2, customer_id: 20}, {id: 3, customer_id: 10}])

    assert_equal [1, 3], customer10.invoices.map { |invoice| invoice.id }
    assert_equal [2], customer20.invoices.map { |invoice| invoice.id }
  end
end
