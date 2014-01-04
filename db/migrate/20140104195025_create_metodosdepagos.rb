class CreateMetodosdepagos < ActiveRecord::Migration
  def change
    create_table :metodosdepagos do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
