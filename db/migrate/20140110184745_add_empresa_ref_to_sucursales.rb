class AddEmpresaRefToSucursales < ActiveRecord::Migration
  def change
    add_reference :sucursales, :empresa, index: true
  end
end
