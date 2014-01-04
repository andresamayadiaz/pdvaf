class CreateMonedas < ActiveRecord::Migration
  def change
    create_table :monedas do |t|
      t.string :nombre
      t.string :codigo
      t.decimal :tipocambio

      t.timestamps
    end
  end
end
