class CreateRemisiones < ActiveRecord::Migration
  def change
    create_table :remisiones do |t|
      t.references :cliente, index: true
      t.references :condicionesdepago, index: true
      t.references :formasdepago, index: true
      t.references :metodosdepago, index: true
      t.decimal :subtotal
      t.decimal :descuento
      t.decimal :total
      t.decimal :totalimpuestosretenidos
      t.decimal :totalimpuestostrasladados

      t.timestamps
    end
  end
end
