class AddEmpresaRefToRemisiones < ActiveRecord::Migration
  def change
    add_reference :remisiones, :empresa, index: true
  end
end
