# aad Enero 2014

@acc = pdf
@empresa = @remision.empresa

# Header PDF
def header

  # emisor
  emisor = @acc.make_table [
    [@acc.make_cell(:content => "#{@empresa.razonsocial.upcase}",
      :size => 10, :font_style => :bold, :padding => 2)],
    [@acc.make_cell(:content => "#{@empresa.rfc.upcase}",
      :size => 10, :padding => 2)],
    [@acc.make_cell(:content => 
      "#{@empresa.calle.try(:upcase)}
      #{@empresa.noExterior.try(:upcase)},
      #{'INT: ' << @empresa.noInterior.try(:upcase) << ',' unless @empresa.noInterior.try(:empty?) || @empresa.noInterior.nil?}
      #{@empresa.colonia.try(:upcase)},
      #{@empresa.codigoPostal.try(:upcase)},
      #{@empresa.municipio.try(:upcase)},
      #{@empresa.estado.try(:upcase)}".squish,
      :size => 10, :padding => 2)]
  ], :width => 300
  emisor.cells.select {|a| a.border_width = 0 }
  
  general = nil
  general = @acc.make_table [
    [@acc.make_cell(:content => "REMISION",
      :size => 8, :font_style => :bold, :align => :center, :padding => 2, :border_top_width => 0)],
      [@acc.make_cell(:content => "#{@remision.id}",
        :size => 8, :align => :center, :padding => 2)],
    
    [@acc.make_cell(:content => "CONDICIONES DE PAGO",
      :size => 6, :font_style => :bold, :align => :center, :padding => 2)],
    [@acc.make_cell(:content => "#{@remision.condicionesdepago.nombre rescue ''}",
      :size => 6, :align => :center, :padding => 2)],
    
    [@acc.make_cell(:content => "METODO DE PAGO",
      :size => 6, :font_style => :bold, :align => :center, :padding => 2)],
    [@acc.make_cell(:content => "#{@remision.metodosdepago.nombre rescue ''}",
      :size => 6, :align => :center, :padding => 2)],
    
    [@acc.make_cell(:content => "FORMA DE PAGO",
      :size => 6, :font_style => :bold, :align => :center, :padding => 2)],
    [@acc.make_cell(:content => "#{@remision.formasdepago.nombre rescue ''}",
      :size => 6, :align => :center, :padding => 2)],
      
  ], :width => 100
  general.cells.select {|a| a.border_right_width = 0 && a.border_left_width = 0 }
  
  cabecera1 = @acc.make_table [[emisor, general]], :position => 100, :header => true
  cabecera1.cells.select {|a| a.border_width = 0 }
  cabecera1.draw
  
  @acc.move_down 5
  
  receptor = @acc.make_table [
    [@acc.make_cell(:content => "Cliente:",
      :size => 8, :font_style => :bold, :padding => 2)],
    [@acc.make_cell(:content => "#{@empresa.razonsocial.upcase}",
      :size => 8, :padding => 2)],
    [@acc.make_cell(:content => "#{@empresa.rfc.upcase}",
      :size => 8, :padding => 2)],
    [@acc.make_cell(:content => 
      "#{@empresa.calle.try(:upcase)}
      #{@empresa.noExterior.try(:upcase)},
      #{'INT: ' << @empresa.noInterior.try(:upcase) << ',' unless @empresa.noInterior.try(:empty?) || @empresa.noInterior.nil?}
      #{@empresa.colonia.try(:upcase)},
      #{@empresa.codigoPostal.try(:upcase)},
      #{@empresa.municipio.try(:upcase)},
      #{@empresa.estado.try(:upcase)}".squish,
      :size => 8, :padding => 2)]
  ], :width => 500
  receptor.cells.select { |a| a.border_width = 0 }
  receptor.draw
  
end

# Impresion
header