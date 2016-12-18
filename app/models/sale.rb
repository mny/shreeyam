class Sale < ActiveRecord::Base
  belongs_to :product

  validates_presence_of :product_code

  def get_profit
  	(sold_price - product.cost_price) * quantity if (sold_price && product.cost_price && quantity)
  end
end
