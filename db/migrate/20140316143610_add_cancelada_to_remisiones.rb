class AddCanceladaToRemisiones < ActiveRecord::Migration
  def change
    add_column :remisiones, :cancelada, :boolean, :default => true
    add_column :remisiones, :fechacancelacion, :datetime
  end
end