class AddImpuestosToConceptos < ActiveRecord::Migration
  def change
    add_column :conceptos, :ivatrasladado, :decimal
    add_column :conceptos, :iepstrasladado, :decimal
    add_column :conceptos, :ivaretenido, :decimal
    add_column :conceptos, :isrretenido, :decimal
  end
end
