class AddEmpresaRefToFormasdepagos < ActiveRecord::Migration
  def change
    add_reference :formasdepagos, :empresa, index: true
  end
end
