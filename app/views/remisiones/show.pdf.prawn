# aad Enero 2014
custom_size = [612.00, 396.00]

@acc = pdf
@empresa = @remision.empresa
@sucursal = @remision.sucursal
@cliente = @remision.cliente
@conceptosTemporal = @remision.conceptos.select {|a| a}

# Header PDF
def header

  # emisor
  emisor = @acc.make_table [
    [@acc.make_cell(:content => "#{@empresa.razonsocial.upcase}",
      :size => 10, :font_style => :bold, :padding => 2, :align => :center)],
    [@acc.make_cell(:content => "#{@empresa.rfc.upcase}",
      :size => 10, :padding => 2, :align => :center)],
    [@acc.make_cell(:content => 
      "#{@empresa.calle.try(:upcase)}
      #{@empresa.noExterior.try(:upcase)},
      #{'INT: ' << @empresa.noInterior.try(:upcase) << ',' unless @empresa.noInterior.try(:empty?) || @empresa.noInterior.nil?}
      #{@empresa.colonia.try(:upcase)},
      #{@empresa.codigoPostal.try(:upcase)},
      #{@empresa.municipio.try(:upcase)},
      #{@empresa.estado.try(:upcase)}".squish,
      :size => 10, :padding => 2, :align => :center)],
      
      [@acc.make_cell(:content => 
        "Sucursal: #{@sucursal.nombre.try(:upcase)},
        Tel. #{@sucursal.telefono.try(:upcase)}".squish,
      :size => 10, :padding => 2, :align => :center)]
      
  ], :width => 300
  emisor.cells.select {|a| a.border_width = 0 }
  
  general = nil
  general = @acc.make_table [
    [@acc.make_cell(:content => "REMISION",
      :size => 8, :font_style => :bold, :align => :center, :padding => 2, :border_top_width => 0)],
      [@acc.make_cell(:content => "#{@remision.id}",
        :size => 8, :align => :center, :padding => 2)],
    
    [@acc.make_cell(:content => "FECHA",
      :size => 6, :font_style => :bold, :align => :center, :padding => 2)],
    [@acc.make_cell(:content => "#{@remision.created_at.to_s(:db) rescue ''}",
      :size => 6, :align => :center, :padding => 2)],
    
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
    [@acc.make_cell(:content => "CLIENTE",
      :size => 8, :font_style => :bold, :padding => 2)],
    [@acc.make_cell(:content => "#{@cliente.nombre.upcase rescue ''}",
      :size => 8, :padding => 2)],
    [@acc.make_cell(:content => "#{@cliente.rfc.upcase rescue ''}",
      :size => 8, :padding => 2)],
    [@acc.make_cell(:content => 
      "#{@cliente.calle.upcase rescue ''}
      #{@cliente.noExterior rescue ''},
      #{'INT: ' << @cliente.noInterior.try(:upcase) << ',' unless @cliente.noInterior.try(:empty?) || @cliente.noInterior.nil?}
      #{@cliente.colonia.upcase rescue ''},
      #{@cliente.codigoPostal.upcase rescue ''},
      #{@cliente.municipio.upcase rescue ''},
      #{@cliente.estado.upcase rescue ''}".squish,
      :size => 8, :padding => 2)]
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
          :size => 9, :padding => 0, :rowspan => 8),
        @acc.make_cell(:content => "",
          :size => 9, :width => 120, :padding => 0),
        @acc.make_cell(:content => "",
          :size => 9, :width => 120, :padding => 0, :align => :right)
      ],
      
      [@acc.make_cell(:content => "SUBTOTAL:",
          :size => 9, :width => 120, :padding => 0),
        @acc.make_cell(:content => "#{number_to_currency(@remision.subtotal)}",
          :size => 9, :width => 120, :padding => 0, :align => :right)
      ],
      [@acc.make_cell(:content => "DESCUENTO:",
          :size => 9, :width => 120, :padding => 0),
        @acc.make_cell(:content => "#{number_with_precision(@remision.descuento, precision: 2)}%",
          :size => 9, :width => 120, :padding => 0, :align => :right)
      ],
      [@acc.make_cell(:content => "I.V.A.:",
          :size => 9, :width => 120, :padding => 0),
        @acc.make_cell(:content => "#{number_to_currency(@remision.ivaTrasladado.to_f)}",
          :size => 9, :width => 120, :padding => 0, :align => :right)
      ],
      [@acc.make_cell(:content => "I.E.P.S.:",
          :size => 9, :width => 120, :padding => 0),
        @acc.make_cell(:content => "#{number_to_currency(@remision.iepsTrasladado.to_f)}",
          :size => 9, :width => 120, :padding => 0, :align => :right)
      ],
      [@acc.make_cell(:content => "RET I.V.A.:",
          :size => 9, :width => 120, :padding => 0),
        @acc.make_cell(:content => "#{number_to_currency(@remision.ivaRetenido.to_f)}",
          :size => 9, :width => 120, :padding => 0, :align => :right)
      ],
      [@acc.make_cell(:content => "RET I.S.R.:",
          :size => 9, :width => 120, :padding => 0),
        @acc.make_cell(:content => "#{number_to_currency(@remision.isrRetenido.to_f)}",
          :size => 9, :width => 120, :padding => 0, :align => :right)
      ],
      [@acc.make_cell(:content => "TOTAL:",
          :size => 9, :width => 120, :padding => 0),
        @acc.make_cell(:content => "#{number_to_currency(@remision.total)}",
          :size => 9, :width => 120, :padding => 0, :align => :right)
      ],
    ], :width => 500
    
     pie0.cells.select {|a| a.border_width = 0 }
     @acc.move_down 160
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
        :font_style => :bold, :size => 9, :width => 60, :border_width => 0, :border_bottom_width => 1, :padding => 1),
      @acc.make_cell(:content => "CONCEPTO",
        :font_style => :bold, :size => 9, :width => 300, :border_width => 0, :border_bottom_width => 1, :padding => 1),
      @acc.make_cell(:content => "UNIDAD DE MEDIDA",
        :font_style => :bold, :size => 9, :width => 80, :border_width => 0, :border_bottom_width => 1, :padding => 1),
      @acc.make_cell(:content => "IMPORTE",
        :font_style => :bold, :size => 9, :width => 60, :align => :right, :border_width => 0, :border_bottom_width => 1, :padding => 1)],
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
table_tmp = nil

@conceptosTemporal.delete_if do |item|
  item_cells.push [
    @acc.make_cell(:content => item.cantidad.to_s, :size => 9, :width => 60, :border_width => 0, :padding => 1),
    @acc.make_cell(:content => item.descripcion, :size => 9, :width => 300, :border_width => 0, :padding => 1),
    @acc.make_cell(:content => item.unidad, :size => 9, :width => 80, :border_width => 0, :padding => 1),
    @acc.make_cell(:content => number_to_currency(item.importe), :size => 9, :align => :right, :width => 60, :border_width => 0, :padding => 1),
  ]
  
  logger.debug "CELL SIZE: " << item_cells.size.to_s
  
  # Verifica el Tamano
  if item_cells.size > 5
     @acc.start_new_page
    header
    items(item_cells)
    footer
    
    table_tmp = nil
    item_cells = Array.new
    count = 0
    
    logger.debug "quiebre///"
    
    true
    next
  else
    logger.debug "TEMP CON: " << @conceptosTemporal.size.to_s
    if @conceptosTemporal.size == 1
      header
      items(item_cells)
      footer
    end

    true
  end

  table_tmp = @acc.make_table [
    [item_cells]
  ], :width => 500

  true
end