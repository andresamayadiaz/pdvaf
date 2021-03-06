class RemisionesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_remision, only: [:show, :edit, :update, :destroy, :facturar, :series, :copiar, :ticket]

  # GET /remisiones/1/ticket
  def ticket

    response = emite_ticket

    if response['exito'] == 1
      redirect_to @remision, notice: 'Ticket de Autofacturacion Generado. [' + response['codigof'] + ']'
    else
      redirect_to @remision, alert: 'Ticket No Emitido. ' + response['mensaje']
    end

  end

  # GET /remisiones/1/facturar
  def facturar

    clienteFactura = Cliente.find(params[:cliente_id])
    if clienteFactura.blank?
      redirect_to @remision, alert: 'Cliente a Facturar Invalido, Favor de Verificar'
    end

    af = Autofactura::Autofactura.new({ :url=> current_user.empresa.af_url, :user => current_user.empresa.af_user, :sucursal => @remision.sucursal.af_sucursal })
    conceptos = Array.new
    @remision.conceptos.each do |concepto|

      conceptos.push ({:cantidad => concepto.cantidad.to_f,
          :unidad => concepto.unidad.to_s,
          :descripcion => concepto.descripcion.to_s,
          :valorUnitario => concepto.valorunitario.to_f,
          :ret_iva => concepto.ivaretenido.to_f,
          :tras_ieps => concepto.iepstrasladado.to_f,
          :tras_iva => concepto.ivatrasladado.to_f,
          :ret_isr => concepto.isrretenido.to_f})

    end

    comp = {
      :serie => params[:serie],
      :tipoDeComprobante => "ingreso",
      :condicionesDePago => @remision.condicionesdepago.nombre.to_s,
      :formaDePago => @remision.formasdepago.nombre.to_s,
      :metodoDePago => @remision.metodosdepago.nombre.to_s,
      :numerocta => "NO IDENTIFICADO",
      :version => "3.2",
      :tipoCambio => 1,
      :moneda => "MXN",
      :decimales => current_user.empresa.decimales,
      :descuento_porcentual => @remision.descuento.to_f,
      :Receptor => {
        :rfc => clienteFactura.rfc.to_s,
        :nombre => clienteFactura.nombre.to_s,
        :email => clienteFactura.email.to_s,
        :Domicilio => {
          :noExterior => clienteFactura.noExterior.to_s,
          :noInterior => clienteFactura.noInterior.to_s,
          :calle => clienteFactura.calle.to_s,
          :colonia => clienteFactura.colonia.to_s,
          :municipio => clienteFactura.municipio.to_s,
          :estado => clienteFactura.estado.to_s,
          :pais => clienteFactura.pais.to_s,
          :codigoPostal => clienteFactura.codigoPostal.to_s,
          :referencia => params[:referencia]
        } # Fin Domicilio
      }, # Fin Receptor
      :Addenda => ""
     }
     comp[:Conceptos] = conceptos
     logger.debug "-----------------------------------------"
     logger.debug "COMPROBANTE POR ENVIAR A AUTOFACTURA.COM"
     logger.debug "-----------------------------------------"
     logger.debug comp.to_json
     logger.debug "-----------------------------------------"
     logger.debug "FIN DEL COMPROBANTE"
     logger.debug "-----------------------------------------"

     comprobante = Autofactura::Comprobante.new( comp )
     #logger.info "Comprobante subTotal: " + comprobante.subTotal.to_s
     resp = af.emitir(comprobante)

     unless resp.nil?
       logger.info resp.body
       response = JSON.parse resp.body
       if response['exito'] == 1

         @remision.facturada = true
         @remision.clientefactura = clienteFactura
         @remision.uuid = response['uuid']
         @remision.af_id = response['id']
         @remision.seriefolio = response['Folio']
         @remision.pdf_url = 'http://app.autofactura.com/cfdis/cfdipdf/' + response['id']
         @remision.xml_url = response['url']
         @remision.save

         redirect_to @remision, notice: 'Remision Facturada.'

       else

         redirect_to @remision, alert: 'Remision No Facturada. ' + response['mensaje']

       end
     else
       redirect_to @remision, alert: 'Remision No Facturada. Verificar Configuracion de AutoFactura.com.'
     end

  end

  # GET /remisiones/1/series
  def series

    af = Autofactura::Autofactura.new({ :user => current_user.empresa.af_user, :sucursal => @remision.sucursal.af_sucursal })
    @series = af.series
    respond_to do |format|
        format.html { redirect_to @remision, notice: 'No se puede acceder al metodo.' }
        format.json { render :json => @series }
      end

  end

  # GET /remisiones/rptventas
  def rptventas

    authorize! :rptventas, current_user.empresa.remisiones.new

    @sucursales = current_user.empresa.sucursales.load

    if params[:search]

      @desde = params[:desde] + " 00:00:00"
      @hasta = params[:hasta] + " 23:59:59"
      @sucursal = params[:sucursal]

      if @sucursal.empty?
        @remisiones = current_user.empresa.remisiones.where("created_at between ?  AND ?", @desde.to_time, @hasta.to_time).order(sucursal_id: :asc, created_at: :desc)
      else
        @remisiones = current_user.empresa.remisiones.where("created_at between ?  AND ? AND sucursal_id = ?", @desde.to_time, @hasta.to_time, @sucursal).order(sucursal_id: :asc, created_at: :desc)
      end

      respond_to do |format|
        response.headers["Content-Type"] = "text/html"
        response.header["Content-Disposition"] = "attachment; filename=RptVentas.xls"
        format.xls
      end

    end

  end

  # GET /remisiones/rptventasporproducto
  def rptventasporproducto

    authorize! :rptventasporproducto, current_user.empresa.remisiones.new

    @sucursales = current_user.empresa.sucursales.load

    if params[:search]

      @desde = params[:desde] + " 00:00:00"
      @hasta = params[:hasta] + " 23:59:59"
      @sucursal = params[:sucursal]

      if @sucursal.empty?
        @remisiones = current_user.empresa.remisiones.where("created_at between ?  AND ?", @desde.to_time, @hasta.to_time).order(sucursal_id: :asc, created_at: :desc)
      else
        @remisiones = current_user.empresa.remisiones.where("created_at between ?  AND ? AND sucursal_id = ?", @desde.to_time, @hasta.to_time, @sucursal).order(sucursal_id: :asc, created_at: :desc)
      end

      respond_to do |format|
        response.headers["Content-Type"] = "text/html"
        response.header["Content-Disposition"] = "attachment; filename=RptVentasPorProducto.xls"
        format.xls
      end

    end

  end

  # GET /remisiones/rptmetodopago
  def rptmetodopago

    authorize! :rptmetodopago, current_user.empresa.remisiones.new

    @sucursales = current_user.empresa.sucursales.load

    if params[:search]

      @desde = params[:desde] + ' 00:00:00'
      @hasta = params[:hasta] + ' 23:59:59'
      @sucursal = current_user.empresa.sucursales.find(params[:sucursal])

      @fechas = (Date.parse(@desde)..Date.parse(@hasta)).map{|date| date.strftime('%Y-%m-%d')}
      @metodosdepago = current_user.empresa.metodosdepagos.load

      @ventas = @sucursal.remisiones.select(['DATE(convert_tz(created_at, "+00:00", "-06:00")) AS fecha', 'metodosdepago_id', 'sum(total) AS total']).where("cancelada = false AND created_at between ? AND ?", @desde.to_time, @hasta.to_time).group(['DATE(convert_tz(created_at, "+00:00", "-06:00"))', 'metodosdepago_id']).order('created_at ASC')

      j = JSON.parse(@ventas.to_json)
      #@h = j.map {|c| [ [c['fecha'], Metodosdepago.find(c['metodosdepago_id']).nombre]=>c['total'] ]}
      @h = j.map {|c| { c['fecha'].to_s+"@"+c['metodosdepago_id'].to_s=>c['total'] } }

      respond_to do |format|
        response.headers["Content-Type"] = "text/html"
        response.header["Content-Disposition"] = "attachment; filename=RptVentasMetodoPago.xls"
        format.xls
      end

    end

  end

  # GET /remisiones
  # GET /remisiones.json
  def index

    @clientes = current_user.empresa.clientes.load

    if params[:search]
      desde = params[:desde] + ' 00:00:00'
      hasta = params[:hasta] + ' 23:59:59'
      cliente = params[:cliente_id]
      #@remisiones = current_user.empresa.remisiones.find(:all, :conditions => ["created_at >= ? AND created_at <= ?",desde, hasta]).page params[:page]
      if cliente.empty?

        if current_user.has_role? :gerente
          @remisiones = current_user.empresa.remisiones.where("created_at between ? AND ?",desde.to_time, hasta.to_time).page params[:page]
        else
          @remisiones = current_user.sucursal.remisiones.where("created_at between ? AND ?",desde.to_time, hasta.to_time).page params[:page]
        end

      else

        if current_user.has_role? :gerente
          @remisiones = current_user.empresa.remisiones.where("created_at between ? AND ? AND cliente_id = ?",desde.to_time, hasta.to_time, cliente).page params[:page]
        else
          @remisiones = current_user.sucursal.remisiones.where("created_at between ? AND ? AND cliente_id = ?",desde.to_time, hasta.to_time, cliente).page params[:page]
        end

      end

    else

      if current_user.has_role? :gerente
        @remisiones = current_user.empresa.remisiones.page params[:page]
      else
        @remisiones = current_user.sucursal.remisiones.page params[:page]
      end
    end
  end

  # GET /remisiones/1
  # GET /remisiones/1.json
  # GET /remisiones/1.pdf
  def show

    respond_to do |format|
      format.html
      format.json { render :json => @remision }
      format.pdf do
        render :layout => false
      end
      format.txt do
        render :layout => false
      end
    end

  end

  # GET /remisiones/new
  def new
    @remision = current_user.empresa.remisiones.new
    @clientes = current_user.empresa.clientes.load
    @formasdepago = current_user.empresa.formasdepagos.load
    @metodosdepago = current_user.empresa.metodosdepagos.load
    @condicionesdepago = current_user.empresa.condicionesdepagos.load

    @lista_default = Cliente.find(current_user.empresa.clientedefault).listadeprecio.id

    # Validate
    if @clientes.size <= 0
      redirect_to clientes_path, alert: 'Debes tener al menos un cliente.'
    end
    if @formasdepago.size <= 0
      redirect_to formasdepagos_path, alert: 'Debes tener al menos una Forma de Pago.'
    end
    if @metodosdepago.size <= 0
      redirect_to metodosdepagos_path, alert: 'Debes tener al menos un Metodo de Pago.'
    end
    if @condicionesdepago.size <= 0
      redirect_to condicionesdepagos_path, alert: 'Debes tener al menos una Condicion de Pago.'
    end

  end

  # GET /remisiones/1/edit
  def edit

  end

  # Get /remisiones/1/copiar
  def copiar

    @clientes = current_user.empresa.clientes.load
    @formasdepago = current_user.empresa.formasdepagos.load
    @metodosdepago = current_user.empresa.metodosdepagos.load
    @condicionesdepago = current_user.empresa.condicionesdepagos.load
    @copiaremision = current_user.empresa.remisiones.new
    @lista_default = Cliente.find(current_user.empresa.clientedefault).listadeprecio.id

  end

  # POST /remisiones
  # POST /remisiones.json
  def create
    @remision = current_user.empresa.remisiones.new(remision_params)
    # Recalcular totales para asegurar integridad
    @remision.calc_totales

    @remision.empresa = current_user.empresa
    sucursal = Sucursal.find(current_user.sucursal)
    sucursal.lock!
    @remision.sucursal = sucursal
    @remision.consecutivo = sucursal.consecutivo
    sucursal.consecutivo += 1

    respond_to do |format|
      if @remision.save
        sucursal.save!

        # Emitir Ticket Automatico?
        if current_user.empresa.ticket

          emite_ticket

        end

        format.html { redirect_to @remision, notice: 'La Remision ha sido creada con exito.' }
        format.json { render action: 'show', status: :created, location: @remision }

      else
        sucursal.consecutivo -= 1
        sucursal.save!
        format.html {
          @clientes = current_user.empresa.clientes.load
          @formasdepago = current_user.empresa.formasdepagos.load
          @metodosdepago = current_user.empresa.metodosdepagos.load
          @condicionesdepago = current_user.empresa.condicionesdepagos.load
          render action: 'new'
        }
        format.json { render json: @remision.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /remisiones/1
  # PATCH/PUT /remisiones/1.json
  def update
    respond_to do |format|
      if @remision.update(remision_params)
        format.html { redirect_to @remision, notice: 'Remision was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @remision.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /remisiones/1
  # DELETE /remisiones/1.json
  def destroy

    authorize! :destroy, @remision

    @remision.cancelar
    respond_to do |format|
      format.html { redirect_to remisiones_url, notice: 'Remision Cancelada.' }
      format.json { head :no_content }
    end
  end

  private

  def emite_ticket

    af = Autofactura::Autofactura.new({ :url=> current_user.empresa.af_url, :user => current_user.empresa.af_user, :sucursal => @remision.sucursal.af_sucursal })
    articulos = Array.new

    @remision.conceptos.each do |concepto|

      articulos.push ({
          :cantidades => concepto.cantidad.to_f,
          :unidades => concepto.unidad.to_s,
          :nombre => concepto.descripcion.to_s,
          :precios => concepto.valorunitario.to_f,
          :ivaret => concepto.ivaretenido.to_f,
          :iepstrans => concepto.iepstrasladado.to_f,
          :ivatrans => concepto.ivatrasladado.to_f,
          :isret => concepto.isrretenido.to_f})

    end

    nota = {
      :Ingreso => {
        :sucursal => @remision.sucursal.af_sucursal,
        :formaDePago => @remision.formasdepago.nombre.to_s,
        :metodoDePago => @remision.metodosdepago.nombre.to_s,
        :moneda => "MXN",
        :tipoCambio => "1.00",
        :descuento => @remision.descuento.to_f
      },
      :Articulos => articulos,
      :decimales => current_user.empresa.decimales
    }

    logger.debug "-----------------------------------------"
    logger.debug "TICKET POR ENVIAR A AUTOFACTURA.COM"
    logger.debug "-----------------------------------------"
    logger.debug nota.to_json
    logger.debug "-----------------------------------------"
    logger.debug "FIN DEL TICKET"
    logger.debug "-----------------------------------------"

    emision_ticket = Autofactura::Nota.new( nota )
    resp = af.ticket(emision_ticket)

    unless resp.nil?
      logger.info resp.body
      response = JSON.parse resp.body
      if response['exito'] == 1

        @remision.autoticket = true
        @remision.ticket = response['codigof']
        @remision.save

        return response
      else

        return response
      end
    else

      return false
    end

  end

    # Use callbacks to share common setup or constraints between actions.
    def set_remision
      @remision = current_user.empresa.remisiones.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def remision_params
      params.require(:remision).permit(:serie, :cliente_id, :condicionesdepago_id, :formasdepago_id, :metodosdepago_id, :subtotal, :descuento, :total, :totalimpuestosretenidos, :totalimpuestostrasladados, conceptos_attributes: [:id, :codigo, :costo, :cantidad, :unidad, :descripcion, :valorunitario, :importe, :ivatrasladado, :iepstrasladado, :ivaretenido, :isrretenido])
    end
end
