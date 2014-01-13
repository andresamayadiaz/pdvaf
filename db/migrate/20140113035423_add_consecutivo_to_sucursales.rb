class AddConsecutivoToSucursales < ActiveRecord::Migration
  def change
    add_column :sucursales, :consecutivo, :integer
  end
end
