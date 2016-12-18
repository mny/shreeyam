class Product < ActiveRecord::Base

  has_many :sale

  validates_presence_of :name
  validates_presence_of :item_code
  validates_uniqueness_of :item_code

  attr_accessor :added_no_of_items
  attr_accessor :no_of_items_moved_to_shop

  def get_cost_price
    real_price + (real_price * variable_cost_percent/100) if (real_price && variable_cost_percent)
  end

  def get_real_price
    cost_at_supplier * exchange_rate if (cost_at_supplier && exchange_rate)
  end

end
