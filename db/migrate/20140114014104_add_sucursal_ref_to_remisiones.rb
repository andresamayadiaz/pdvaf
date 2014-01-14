class AddSucursalRefToRemisiones < ActiveRecord::Migration
  def change
    add_reference :remisiones, :sucursal, index: true
  end
end
