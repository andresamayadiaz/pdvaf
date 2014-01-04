class CreateProductos < ActiveRecord::Migration
  def change
    create_table :productos do |t|
      t.text :nombre
      t.references :unidad, index: true

      t.timestamps
    end
  end
end
