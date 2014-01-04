class CreateTraslados < ActiveRecord::Migration
  def change
    create_table :traslados do |t|
      t.string :tipo
      t.string :nombre
      t.decimal :tasa

      t.timestamps
    end
  end
end
