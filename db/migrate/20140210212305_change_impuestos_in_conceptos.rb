class ChangeImpuestosInConceptos < ActiveRecord::Migration
  def self.up
    change_column :conceptos, :ivatrasladado, :decimal, :precision => 10, :scale => 4
    change_column :conceptos, :iepstrasladado, :decimal, :precision => 10, :scale => 4
    change_column :conceptos, :ivaretenido, :decimal, :precision => 10, :scale => 4
    change_column :conceptos, :isrretenido, :decimal, :precision => 10, :scale => 4
  end
end
