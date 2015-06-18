require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'

class ItemTest < Minitest::Test
  def test_it_has_a_name
    item_data = {id: 1, name: "Widget"}
    item_repository = "ITEM REPOSITORY"
    item = Item.new(item_data, item_repository)

    assert_equal "Widget", item.name
  end
end