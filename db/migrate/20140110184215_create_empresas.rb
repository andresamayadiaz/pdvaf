class CreateEmpresas < ActiveRecord::Migration
  def change
    create_table :empresas do |t|
      t.text :razonsocial
      t.string :rfc
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
