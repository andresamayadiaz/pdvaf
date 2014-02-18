class AddClienfeFactuarToRemisiones < ActiveRecord::Migration
  def change
    add_column :remisiones, :clientefactura_id, :integer
  end
end
