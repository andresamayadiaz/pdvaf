class AddEmpresaRefToCondicionesdepagos < ActiveRecord::Migration
  def change
    add_reference :condicionesdepagos, :empresa, index: true
  end
end
