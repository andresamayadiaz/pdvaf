class CreatePrecios < ActiveRecord::Migration
  def change
    create_table :precios do |t|
      t.belongs_to :producto, index: true
      t.belongs_to :moneda, index: true
      t.decimal :precio

      t.timestamps
    end
    
    add_index :precios, [:producto_id, :moneda_id], :unique => true
  end
end
