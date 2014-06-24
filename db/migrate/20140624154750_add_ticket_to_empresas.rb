class AddTicketToEmpresas < ActiveRecord::Migration
  def change
    add_column :empresas, :ticket, :boolean
  end
end
