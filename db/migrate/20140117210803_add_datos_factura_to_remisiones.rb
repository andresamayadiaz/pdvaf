class AddDatosFacturaToRemisiones < ActiveRecord::Migration
  def change
    add_column :remisiones, :facturada, :boolean
    add_column :remisiones, :uuid, :string
    add_column :remisiones, :af_id, :string
    add_column :remisiones, :seriefolio, :string
    add_column :remisiones, :pdf_url, :text
    add_column :remisiones, :xml_url, :text
  end
end
