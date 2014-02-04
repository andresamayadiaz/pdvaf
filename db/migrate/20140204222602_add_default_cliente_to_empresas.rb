class AddDefaultClienteToEmpresas < ActiveRecord::Migration
  def change
    add_column :empresas, :clientedefault, :integer
  end
end
