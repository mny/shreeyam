class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :item_code
   	  t.string :description
      t.float :real_price , :limit => 53
      t.float :variable_cost_percent
      t.float :cost_price , :limit => 53
      t.float :sale_price , :limit => 53
      t.float :quantity , :null => false , :default => 0
      t.float :quantity_godown , :null => false , :default => 0
      t.float :quantity_shop , :default => 0
      t.float :profit_on_stock , :limit => 53

      t.timestamps
    end
  end
end
