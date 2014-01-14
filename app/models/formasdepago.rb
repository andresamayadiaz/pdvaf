class Formasdepago < ActiveRecord::Base
  belongs_to :empresa
  
  default_scope { order('nombre ASC') }
  
end
