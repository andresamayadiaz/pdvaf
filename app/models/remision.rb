class Remision < ActiveRecord::Base
  belongs_to :cliente
  belongs_to :condicionesdepago
  belongs_to :formasdepago
  belongs_to :metodosdepago
  has_many :conceptos
end
