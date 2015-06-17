class Item
  attr_reader :item_repository, :item_data

  def initialize(item_data, item_repository="INSERT REPO")
    @item_data = item_data
    @item_repository = item_repository
  end

  def id
    item_data[:id]
  end

  def name
    item_data[:name]
  end

  def description
    item_data[:description]
  end

  def unit_price
    item_data[:unit_price]
  end

  def merchant_id
    item_data[:merchant_id]
  end

  def created_at
    item_data[:created_at]
  end

  def updated_at
    item_data[:updated_at]
  end
end
