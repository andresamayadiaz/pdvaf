class AddCodigoToConceptos < ActiveRecord::Migration
  def change
    add_column :conceptos, :codigo, :string
  end
end
