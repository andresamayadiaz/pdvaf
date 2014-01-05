class CreateConceptos < ActiveRecord::Migration
  def change
    create_table :conceptos do |t|
      t.decimal :cantidad
      t.string :unidad
      t.text :descripcion
      t.decimal :valorunitario
      t.decimal :importe
      t.references :remision, index: true

      t.timestamps
    end
  end
end
