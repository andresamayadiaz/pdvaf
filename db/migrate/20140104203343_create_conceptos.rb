class CreateConceptos < ActiveRecord::Migration
  def change
    create_table :conceptos do |t|
      t.decimal :cantidad
      t.string :unidad
      t.text :descripcion
      t.decimal :valorUnitario
      t.decimal :importe

      t.timestamps
    end
  end
end
