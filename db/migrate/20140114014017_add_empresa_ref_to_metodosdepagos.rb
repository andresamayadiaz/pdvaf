class AddEmpresaRefToMetodosdepagos < ActiveRecord::Migration
  def change
    add_reference :metodosdepagos, :empresa, index: true
  end
end
