class CreatePurchases < ActiveRecord::Migration[6.0]
  def up
    create_table :purchases do |t|
      t.references :customer, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
      t.references :seller, index: true, foreign_key: true
      t.integer :quantity
      t.timestamps
    end
  end

  def down 
    drop_table :purchases
  end

end
