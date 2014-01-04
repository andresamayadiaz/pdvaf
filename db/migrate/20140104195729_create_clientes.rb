class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.string :rfc
      t.text :nombre
      t.string :email
      t.string :noExterior
      t.string :noInterior
      t.string :calle
      t.string :colonia
      t.string :municipio
      t.string :estado
      t.string :pais
      t.string :codigoPostal

      t.timestamps
    end
  end
end
