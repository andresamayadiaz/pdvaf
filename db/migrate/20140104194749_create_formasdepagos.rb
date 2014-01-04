class CreateFormasdepagos < ActiveRecord::Migration
  def change
    create_table :formasdepagos do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
