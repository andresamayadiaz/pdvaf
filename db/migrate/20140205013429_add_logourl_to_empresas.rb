class AddLogourlToEmpresas < ActiveRecord::Migration
  def change
    add_column :empresas, :af_logo, :string
  end
end
