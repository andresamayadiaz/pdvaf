class AddConsecutivoToRemisiones < ActiveRecord::Migration
  def change
    add_column :remisiones, :consecutivo, :integer
  end
end
