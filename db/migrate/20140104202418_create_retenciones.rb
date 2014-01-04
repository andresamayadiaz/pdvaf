class CreateRetenciones < ActiveRecord::Migration
  def change
    create_table :retenciones do |t|
      t.string :tipo
      t.string :nombre
      t.decimal :tasa

      t.timestamps
    end
  end
end
