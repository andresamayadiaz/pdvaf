class CreateListadeprecios < ActiveRecord::Migration
  def change
    create_table :listadeprecios do |t|
      t.string :nombre
      t.text :descripcion

      t.timestamps
    end
  end
end
