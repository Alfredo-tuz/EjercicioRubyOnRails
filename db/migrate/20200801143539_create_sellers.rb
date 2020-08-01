class CreateSellers < ActiveRecord::Migration[6.0]
  def up
    create_table :sellers do |t|
      t.string :name
      t.string :direction

      t.timestamps
    end
  end
  
  def down 
    drop_table :sellers
  end
end
