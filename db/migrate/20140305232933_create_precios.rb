class CreatePrecios < ActiveRecord::Migration
  def change
    create_table :precios do |t|
      t.references :listadeprecio
      t.references :producto
      t.decimal :precio, :precision => 10, :scale => 4

      t.timestamps
    end
  end
end
