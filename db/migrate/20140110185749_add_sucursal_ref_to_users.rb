class AddSucursalRefToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :sucursal, index: true
  end
end
