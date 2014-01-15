class AddEmpresaRefToUnidades < ActiveRecord::Migration
  def change
    add_reference :unidades, :empresa, index: true
  end
end
