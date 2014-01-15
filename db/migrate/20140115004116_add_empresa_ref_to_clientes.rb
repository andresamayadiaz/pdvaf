class AddEmpresaRefToClientes < ActiveRecord::Migration
  def change
    add_reference :clientes, :empresa, index: true
  end
end
