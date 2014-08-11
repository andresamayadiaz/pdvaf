class AddDecimalesToEmpresa < ActiveRecord::Migration
  def change
    add_column :empresas, :decimales, :integer, :default => 3
  end
end
