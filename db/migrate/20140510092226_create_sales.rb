class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.integer :product_id
      t.text :product_code
      t.string :description
      t.float :quantity , :default => 0
      t.float :sold_price , :limit => 53
      t.float :profit , :limit => 53

      t.timestamps
    end
  end
end
