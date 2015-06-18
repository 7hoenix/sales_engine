require_relative '../lib/item'

class ItemRepository
  attr_reader :items, :sales_engine, :item_data

  def initialize(item_data, sales_engine)
    @item_data = item_data
    @sales_engine = sales_engine
    @items = []
    load_up_data
  end

  def load_up_data
    item_data.each do |item|
      items << Item.new(item, self)
    end
  end

  def random
    items.shuffle.first
  end

  def find_item_by_name(name)
    items.find { |item| item.name == name }
  end

  def find_all_items_by_name(name)
    items.select { |item| item.name == name }
  end

  def find_item_by_description(description)
    items.find { |item| item.description == description }
  end

  def find_all_items_by_description(description)
    items.select { |item| item.description == description }
  end

  def find_item_by_unit_price(unit_price)
    items.find { |item| item.unit_price == unit_price }
  end

  def find_all_items_by_unit_price(unit_price)
    items.select { |item| item.unit_price == unit_price }
  end

  def find_item_by_merchant_id(merchant_id)
    items.find { |item| item.merchant_id == merchant_id }
  end

  def find_all_items_by_merchant_id(merchant_id)
    items.select { |item| item.merchant_id == merchant_id }
  end

  def find_item_by_created_at(created_at)
    items.find { |item| item.created_at == created_at }
  end

  def find_all_items_by_created_at(created_at)
    items.select { |item| item.created_at == created_at }
  end

  def find_item_by_updated_at(updated_at)
    items.find { |item| item.updated_at == updated_at }
  end

  def find_all_items_by_updated_at(updated_at)
    items.select { |item| item.updated_at == updated_at }
  end

end
