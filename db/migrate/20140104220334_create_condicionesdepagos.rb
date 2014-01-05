class CreateCondicionesdepagos < ActiveRecord::Migration
  def change
    create_table :condicionesdepagos do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
