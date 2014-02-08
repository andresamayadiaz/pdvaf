# aad Feb 2014
require 'open-uri'

pdf = Prawn::Document.new({:force_download => true, :filename => @remision.id.to_s+".pdf"})
@acc = pdf
@empresa = @remision.empresa
@sucursal = @remision.sucursal
@cliente = @remision.cliente
@conceptosTemporal = @remision.conceptos.select {|a| a}
@letraGde = 8
@letraMed = 6
@letraChi = 4

# Header PDF
def header
  
  @acc.image open(@empresa.af_logo), :width => 120, :at => [0, 735]
  
  # emisor
  emisor = @acc.make_table [
    [@acc.make_cell(:content => "#{@empresa.razonsocial.upcase}",
      :size => @letraGde, :font_style => :bold, :padding => 2, :align => :center)],
    [@acc.make_cell(:content => "#{@empresa.rfc.upcase}",
      :size => @letraGde, :padding => 2, :align => :center)],
    [@acc.make_cell(:content => 
      "#{@empresa.calle.try(:upcase)}
      #{@empresa.noExterior.try(:upcase)},
      #{'INT: ' << @empresa.noInterior.try(:upcase) << ',' unless @empresa.noInterior.try(:empty?) || @empresa.noInterior.nil?}
      #{@empresa.colonia.try(:upcase)},
      #{@empresa.codigoPostal.try(:upcase)},
      #{@empresa.municipio.try(:upcase)},
      #{@empresa.estado.try(:upcase)}".squish,
      :size => @letraGde, :padding => 2, :align => :center)],
      
      [@acc.make_cell(:content => 
        "Sucursal: #{@sucursal.nombre.try(:upcase)},
        Tel. #{@sucursal.telefono.try(:upcase)}".squish,
      :size => @letraGde, :padding => 2, :align => :center)]
      
  ], :width => 300
  emisor.cells.select {|a| a.border_width = 0 }
  
  general = nil
  general = @acc.make_table [
    [@acc.make_cell(:content => "REMISION",
      :size => @letraMed, :font_style => :bold, :align => :center, :padding => 2, :border_top_width => 0)],
      [@acc.make_cell(:content => "#{@remision.consecutivo rescue 'ID: '+@remision.id}",
        :size => @letraMed, :align => :center, :padding => 2)],
    
    [@acc.make_cell(:content => "FECHA",
      :size => @letraChi, :font_style => :bold, :align => :center, :padding => 2)],
    [@acc.make_cell(:content => "#{@remision.created_at.to_s(:db) rescue ''}",
      :size => @letraChi, :align => :center, :padding => 2)],
    
    [@acc.make_cell(:content => "CONDICIONES DE PAGO",
      :size => @letraChi, :font_style => :bold, :align => :center, :padding => 2)],
    [@acc.make_cell(:content => "#{@remision.condicionesdepago.nombre rescue ''}",
      :size => @letraChi, :align => :center, :padding => 2)],
    
    [@acc.make_cell(:content => "METODO DE PAGO",
      :size => @letraChi, :font_style => :bold, :align => :center, :padding => 2)],
    [@acc.make_cell(:content => "#{@remision.metodosdepago.nombre rescue ''}",
      :size => @letraChi, :align => :center, :padding => 2)],
    
    [@acc.make_cell(:content => "FORMA DE PAGO",
      :size => @letraChi, :font_style => :bold, :align => :center, :padding => 2)],
    [@acc.make_cell(:content => "#{@remision.formasdepago.nombre rescue ''}",
      :size => @letraChi, :align => :center, :padding => 2)],
      
  ], :width => 100
  general.cells.select {|a| a.border_right_width = 0 && a.border_left_width = 0 }
  
  cabecera1 = @acc.make_table [[emisor, general]], :position => 100, :header => true
  cabecera1.cells.select {|a| a.border_width = 0 }
  cabecera1.draw
  
  @acc.move_down 0
  
  receptor = @acc.make_table [
    [@acc.make_cell(:content => "CLIENTE",
      :size => @letraMed, :font_style => :bold, :padding => 2)],
    [@acc.make_cell(:content => "#{@cliente.rfc.upcase rescue ''} #{@cliente.nombre.upcase rescue ''}",
      :size => @letraMed, :padding => 2)],
    [@acc.make_cell(:content => 
      "#{@cliente.calle.upcase rescue ''}
      #{@cliente.noExterior rescue ''},
      #{'INT: ' << @cliente.noInterior.try(:upcase) << ',' unless @cliente.noInterior.try(:empty?) || @cliente.noInterior.nil?}
      #{@cliente.colonia.upcase rescue ''},
      #{@cliente.codigoPostal.upcase rescue ''},
      #{@cliente.municipio.upcase rescue ''},
      #{@cliente.estado.upcase rescue ''}".squish,
      :size => @letraMed, :padding => 2)]
  ], :width => 500
  receptor.cells.select { |a| a.border_width = 0 }
  receptor.draw
  
  @acc.move_down 5
  
end

# Footer PDF
def footer
  
  # Totales
  @acc.float do
    pie0 = @acc.make_table [
      [@acc.make_cell(:content => "",
          :size => @letraMed, :padding => 0, :rowspan => 8),
        @acc.make_cell(:content => "",
          :size => @letraMed, :width => 120, :padding => 0),
        @acc.make_cell(:content => "",
          :size => @letraMed, :width => 120, :padding => 0, :align => :right)
      ],
      
      [@acc.make_cell(:content => "SUBTOTAL:",
          :font_style => :bold, :size => @letraMed, :width => 120, :padding => 0),
        @acc.make_cell(:content => "#{number_to_currency(@remision.subtotal, precision: 3 )}",
          :size => @letraMed, :width => 120, :padding => 0, :align => :right)
      ],
      [@acc.make_cell(:content => "DESCUENTO:",
          :font_style => :bold, :size => @letraMed, :width => 120, :padding => 0),
        @acc.make_cell(:content => "#{number_with_precision(@remision.descuento, precision: 3)}%",
          :size => @letraMed, :width => 120, :padding => 0, :align => :right)
      ],
      [@acc.make_cell(:content => "I.V.A.:",
          :font_style => :bold, :size => @letraMed, :width => 120, :padding => 0),
        @acc.make_cell(:content => "#{number_to_currency(@remision.ivaTrasladado.to_f, precision: 3 )}",
          :size => @letraMed, :width => 120, :padding => 0, :align => :right)
      ],
      [@acc.make_cell(:content => "I.E.P.S.:",
          :font_style => :bold, :size => @letraMed, :width => 120, :padding => 0),
        @acc.make_cell(:content => "#{number_to_currency(@remision.iepsTrasladado.to_f, precision: 3 )}",
          :size => @letraMed, :width => 120, :padding => 0, :align => :right)
      ],
      [@acc.make_cell(:content => "RET I.V.A.:",
          :font_style => :bold, :size => @letraMed, :width => 120, :padding => 0),
        @acc.make_cell(:content => "#{number_to_currency(@remision.ivaRetenido.to_f, precision: 3 )}",
          :size => @letraMed, :width => 120, :padding => 0, :align => :right)
      ],
      [@acc.make_cell(:content => "RET I.S.R.:",
          :font_style => :bold, :size => @letraMed, :width => 120, :padding => 0),
        @acc.make_cell(:content => "#{number_to_currency(@remision.isrRetenido.to_f, precision: 3 )}",
          :size => @letraMed, :width => 120, :padding => 0, :align => :right)
      ],
      [@acc.make_cell(:content => "TOTAL:",
          :font_style => :bold, :size => @letraMed, :width => 120, :padding => 0),
        @acc.make_cell(:content => "#{number_to_currency(@remision.total, precision: 3 )}",
          :size => @letraMed, :width => 120, :padding => 0, :align => :right)
      ],
    ], :width => 500
    
     pie0.cells.select {|a| a.border_width = 0 }
     @acc.move_down 150
     pie0.draw
    
  end
    
end

# Cuerpo
def items(item_cells)
  productos1 = @acc.make_table [
      [item_cells]
    ], :width => 500
  productos1.cells.select {|a| a.border_width = 0}

  @acc.float do
    productos = @acc.make_table [
      [@acc.make_cell(:content => "CANTIDAD",
        :font_style => :bold, :size => @letraMed, :width => 60, :border_width => 0, :border_bottom_width => 1, :padding => 1),
      @acc.make_cell(:content => "CONCEPTO",
        :font_style => :bold, :size => @letraMed, :width => 300, :border_width => 0, :border_bottom_width => 1, :padding => 1),
      @acc.make_cell(:content => "UNIDAD DE MEDIDA",
        :font_style => :bold, :size => @letraMed, :width => 80, :border_width => 0, :border_bottom_width => 1, :padding => 1),
      @acc.make_cell(:content => "IMPORTE",
        :font_style => :bold, :size => @letraMed, :width => 60, :align => :right, :border_width => 0, :border_bottom_width => 1, :padding => 1)],
      #[item_cells]
    ], :width => 500
    
    productos.draw
    productos1.draw
    # si es mayor a 238 hay que hacer una nueva pagina
    #if productos.height > 237
    #  header
    #  items
    #  footer
    #end
  end
end

item_cells = Array.new

@conceptosTemporal.delete_if do |item|
  
  item_cells.push [
    @acc.make_cell(:content => item.cantidad.to_s, :size => @letraMed, :width => 60, :border_width => 0, :padding => 1),
    @acc.make_cell(:content => item.descripcion, :size => @letraMed, :width => 300, :border_width => 0, :padding => 1),
    @acc.make_cell(:content => item.unidad, :size => @letraMed, :width => 80, :border_width => 0, :padding => 1),
    @acc.make_cell(:content => number_to_currency(item.importe, precision: 3), :size => @letraMed, :align => :right, :width => 60, :border_width => 0, :padding => 1),
  ]
  
  # Verifica el Tamano
  if item_cells.size > 14
    header
    items(item_cells)
    #footer
    
    #logger.debug ">>>>> " + @conceptosTemporal.size.to_s
    
    if @conceptosTemporal.size > 1
      @acc.start_new_page
    end
    
    item_cells = Array.new
    count = 0
    true
    next
  else
    
    true
  end

  true
end

if item_cells.size >= 1
  header
  items(item_cells)
end
footer