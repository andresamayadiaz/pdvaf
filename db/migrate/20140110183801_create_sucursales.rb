class CreateSucursales < ActiveRecord::Migration
  def change
    create_table :sucursales do |t|
      t.string :nombre
      t.text :direccion
      t.string :telefono
      t.string :email

      t.timestamps
    end
  end
end
