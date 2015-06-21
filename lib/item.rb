require 'bigdecimal'
require 'bigdecimal/util'

class Item
  attr_reader :item_repository, :item_data

  def initialize(item_data, item_repository="INSERT REPO")
    @item_data = item_data
    @item_repository = item_repository
  end

  def id
    item_data[:id].to_i
  end

  def name
    item_data[:name]
  end

  def description
    item_data[:description]
  end

  def unit_price
    BigDecimal.new(item_data[:unit_price]) / 100
  end

  def merchant_id
    item_data[:merchant_id].to_i
  end

  def created_at
    item_data[:created_at]
  end

  def updated_at
    item_data[:updated_at]
  end

#   relationship

  def invoice_items
    item_repository.find_invoice_items_by_item_id(id)
  end

  def merchant
    item_repository.find_merchant_for_item(merchant_id)
  end
end
