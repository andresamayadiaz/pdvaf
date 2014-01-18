class AddAfSucursalToSucursales < ActiveRecord::Migration
  def change
    add_column :sucursales, :af_sucursal, :string
  end
end
