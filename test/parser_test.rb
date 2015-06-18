require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/parser'
require 'csv'

class ParserTest < Minitest::Test
  attr_reader :parser

  def setup
    @parser = Parser.new
  end

  def test_it_parses_merchant_data
    merchant_data = CSV.open "./test/fixtures/merchants.csv", headers: true, header_converters: :symbol
    parsed = parser.parse_merchant_data(merchant_data)
    assert_equal [["1", "Schroeder-Jerde", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["2", "Klein, Rempel and Jones", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["3", "Willms and Sons", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["4", "Cummings-Thiel", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["5", "Williamson Group", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["6", "Williamson Group", "2012-03-27 14:53:59 UTC", "2012-03-27 16:12:25 UTC"], ["7", "Bernhard-Johns", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["8", "Osinski, Pollich and Koelpin", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["9", "Hand-Spencer", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["10", "Bechtelar, Jones and Stokes", "2012-03-27 14:54:00 UTC", "2012-03-27 14:54:00 UTC"]], parsed
  end

  def test_it_parses_customer_data
    customer_data = CSV.open "./test/fixtures/customers.csv", headers: true, header_converters: :symbol
    parsed = parser.parse_customer_data(customer_data)
    assert_equal [["1", "Joey", "Ondricka", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC"], ["2", "Cecelia", "Osinski", "2012-03-27 14:54:10 UTC", "2012-03-27 14:54:10 UTC"], ["3", "Mariah", "Toy", "2012-03-27 14:54:10 UTC", "2012-03-27 14:54:10 UTC"], ["4", "Leanne", "Braun", "2012-03-27 14:54:10 UTC", "2012-03-27 14:54:10 UTC"], ["5", "Sylvester", "Nader", "2012-03-27 14:54:10 UTC", "2012-03-27 14:54:10 UTC"], ["6", "Heber", "Kuhn", "2012-03-27 14:54:10 UTC", "2012-03-27 14:54:10 UTC"], ["7", "Parker", "Daugherty", "2012-03-27 14:54:10 UTC", "2012-03-27 14:54:10 UTC"], ["8", "Loyal", "Considine", "2012-03-27 14:54:11 UTC", "2012-03-27 14:54:11 UTC"], ["9", "Dejon", "Fadel", "2012-03-27 14:54:11 UTC", "2012-03-27 14:54:11 UTC"], ["10", "Ramona", "Reynolds", "2012-03-27 14:54:11 UTC", "2012-03-27 14:54:11 UTC"]], parsed
  end

  def test_it_parses_invoice_item_data
    invoice_item_data = CSV.open "./test/fixtures/invoice_items.csv", headers: true, header_converters: :symbol
    parsed = parser.parse_invoice_item_data(invoice_item_data)
    assert_equal [["1", "539", "1", "5", "13635", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC"], ["2", "528", "1", "9", "23324", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC"], ["3", "523", "1", "8", "34873", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC"], ["4", "535", "1", "3", "2196", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC"], ["5", "529", "1", "7", "79140", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC"], ["6", "541", "1", "5", "52100", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC"], ["7", "530", "1", "4", "66747", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC"], ["8", "534", "1", "6", "76941", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC"], ["9", "1832", "2", "6", "29973", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC"], ["10", "1830", "2", "4", "1859", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC"]], parsed
  end

  def test_it_parses_invoice_data
    invoice_data = CSV.open "./test/fixtures/invoices.csv", headers: true, header_converters: :symbol
    parsed = parser.parse_invoice_data(invoice_data)
    assert_equal [["1", "1", "26", "shipped", "2012-03-25 09:54:09 UTC", "2012-03-25 09:54:09 UTC"], ["2", "1", "75", "shipped", "2012-03-12 05:54:09 UTC", "2012-03-12 05:54:09 UTC"], ["3", "1", "78", "shipped", "2012-03-10 00:54:09 UTC", "2012-03-10 00:54:09 UTC"], ["4", "1", "33", "shipped", "2012-03-24 15:54:10 UTC", "2012-03-24 15:54:10 UTC"], ["5", "1", "41", "shipped", "2012-03-07 19:54:10 UTC", "2012-03-07 19:54:10 UTC"], ["6", "1", "76", "shipped", "2012-03-09 01:54:10 UTC", "2012-03-09 01:54:10 UTC"], ["7", "1", "44", "shipped", "2012-03-07 21:54:10 UTC", "2012-03-07 21:54:10 UTC"], ["8", "1", "38", "shipped", "2012-03-13 16:54:10 UTC", "2012-03-13 16:54:10 UTC"], ["9", "2", "27", "shipped", "2012-03-07 12:54:10 UTC", "2012-03-07 12:54:10 UTC"], ["10", "3", "86", "shipped", "2012-03-06 21:54:10 UTC", "2012-03-06 21:54:10 UTC"]], parsed
  end

  def test_it_parses_item_data
    item_data = CSV.open "./test/fixtures/items.csv", headers: true, header_converters: :symbol
    parsed = parser.parse_item_data(item_data)
    assert_equal [["1", "Item Qui Esse", "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", "75107", "1", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["2", "Item Autem Minima", "Cumque consequuntur ad. Fuga tenetur illo molestias enim aut iste. Provident quo hic aut. Aut quidem voluptates dolores. Dolorem quae ab alias tempora.", "67076", "1", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["3", "Item Ea Voluptatum", "Sunt officia eum qui molestiae. Nesciunt quidem cupiditate reiciendis est commodi non. Atque eveniet sed. Illum excepturi praesentium reiciendis voluptatibus eveniet odit perspiciatis. Odio optio nisi rerum nihil ut.", "32301", "1", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["4", "Item Nemo Facere", "Sunt eum id eius magni consequuntur delectus veritatis. Quisquam laborum illo ut ab. Ducimus in est id voluptas autem.", "4291", "1", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["5", "Item Expedita Aliquam", "Voluptate aut labore qui illum tempore eius. Corrupti cum et rerum. Enim illum labore voluptatem dicta consequatur. Consequatur sunt consequuntur ut officiis.", "68723", "1", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["6", "Item Provident At", "Numquam officiis reprehenderit eum ratione neque tenetur. Officia aut repudiandae eum at ipsum doloribus. Iure minus itaque similique. Ratione dicta alias asperiores minima ducimus nesciunt at.", "15925", "1", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["7", "Item Expedita Fuga", "Fuga assumenda occaecati hic dolorem tenetur dolores nisi. Est tenetur adipisci voluptatem vel. Culpa adipisci consequatur illo. Necessitatibus quis quo velit sed repellendus ut amet.", "31163", "1", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["8", "Item Est Consequuntur", "Reprehenderit est officiis cupiditate quia eos. Voluptatem illum reprehenderit quo vel eligendi. Et eum omnis id ut aliquid veniam.", "34355", "1", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["9", "Item Quo Magnam", "Culpa deleniti adipisci voluptates aut. Sed eum quisquam nisi. Voluptatem est rerum est qui id reprehenderit. Molestiae laudantium non velit alias. Ipsa consequatur modi quibusdam.", "22582", "1", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"], ["10", "Item Quidem Suscipit", "Reiciendis sed aperiam culpa animi laudantium. Eligendi veritatis sint dolorem asperiores. Earum alias illum eos non rerum.", "34018", "1", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC"]], parsed
  end

  def test_it_transaction_data
    transaction_data = CSV.open "./test/fixtures/transactions.csv", headers: true, header_converters: :symbol
    parsed = parser.parse_transaction_data(transaction_data)
    assert_equal [["1", "1", "4654405418249632", nil, "success", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC"], ["2", "2", "4580251236515201", nil, "success", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC"], ["3", "4", "4354495077693036", nil, "success", "2012-03-27 14:54:10 UTC", "2012-03-27 14:54:10 UTC"], ["4", "5", "4515551623735607", nil, "success", "2012-03-27 14:54:10 UTC", "2012-03-27 14:54:10 UTC"], ["5", "6", "4844518708741275", nil, "success", "2012-03-27 14:54:10 UTC", "2012-03-27 14:54:10 UTC"], ["6", "7", "4203696133194408", nil, "success", "2012-03-27 14:54:10 UTC", "2012-03-27 14:54:10 UTC"], ["7", "8", "4801647818676136", nil, "success", "2012-03-27 14:54:10 UTC", "2012-03-27 14:54:10 UTC"], ["8", "9", "4540842003561938", nil, "success", "2012-03-27 14:54:10 UTC", "2012-03-27 14:54:10 UTC"], ["9", "10", "4140149827486249", nil, "success", "2012-03-27 14:54:10 UTC", "2012-03-27 14:54:10 UTC"], ["10", "11", "4923661117104166", nil, "success", "2012-03-27 14:54:10 UTC", "2012-03-27 14:54:10 UTC"]], parsed
  end

end

  # "1, Schroeder-Jerde, 2012-03-27 14 : 53 : 59 UTC, 2012-03-27 14 : 53 : 59 UTC "
