class Metodosdepago < ActiveRecord::Base
  
  default_scope { order('nombre ASC') }
  
end
