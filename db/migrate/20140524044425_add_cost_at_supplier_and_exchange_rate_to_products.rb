class AddCostAtSupplierAndExchangeRateToProducts < ActiveRecord::Migration
  def change
  	add_column :products , :cost_at_supplier, :float
  	add_column :products , :exchange_rate, :float
  end
end
