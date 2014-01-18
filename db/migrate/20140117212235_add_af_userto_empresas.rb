class AddAfUsertoEmpresas < ActiveRecord::Migration
  def change
    add_column :empresas, :af_user, :string
    add_column :empresas, :af_url, :string
  end
end
