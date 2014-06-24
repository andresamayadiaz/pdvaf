class AddTicketToRemisiones < ActiveRecord::Migration
  def change
    add_column :remisiones, :ticket, :string, :default => nil
    add_column :remisiones, :autoticket, :boolean, :default => false
  end
end
