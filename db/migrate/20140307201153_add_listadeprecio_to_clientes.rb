class AddListadeprecioToClientes < ActiveRecord::Migration
  def change
    add_reference :clientes, :listadeprecio, index: true
  end
end
