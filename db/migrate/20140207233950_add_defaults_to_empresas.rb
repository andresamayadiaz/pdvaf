class AddDefaultsToEmpresas < ActiveRecord::Migration
  def change
    add_column :empresas, :formapagodefault, :integer
    add_column :empresas, :metodopagodefault, :integer
    add_column :empresas, :condicionpagodefault, :integer
  end
end
