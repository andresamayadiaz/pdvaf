class AddEmpresaToListadeprecio < ActiveRecord::Migration
  def change
    add_reference :listadeprecios, :empresa, index: true
  end
end
