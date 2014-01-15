class RemisionesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_remision, only: [:show, :edit, :update, :destroy]

  # GET /remisiones
  # GET /remisiones.json
  def index
    if params[:search]
      desde = params[:desde] + ' 00:00:00'
      hasta = params[:hasta] + ' 23:59:59'
      #@remisiones = current_user.empresa.remisiones.find(:all, :conditions => ["created_at >= ? AND created_at <= ?",desde, hasta]).page params[:page]
      @remisiones = current_user.empresa.remisiones.where("created_at >= ? AND created_at <= ?",desde, hasta).page params[:page]
    else
      @remisiones = current_user.empresa.remisiones.page params[:page]
    end
  end

  # GET /remisiones/1
  # GET /remisiones/1.json
  def show
  end

  # GET /remisiones/new
  def new
    @remision = current_user.empresa.remisiones.new
    @clientes = Cliente.all
    @formasdepago = current_user.empresa.formasdepagos.all
    @metodosdepago = current_user.empresa.metodosdepagos.all
  end

  # GET /remisiones/1/edit
  def edit
  end

  # POST /remisiones
  # POST /remisiones.json
  def create
    @remision = current_user.empresa.remisiones.new(remision_params)
    # Recalcular totales para asegurar integridad
    @remision.calc_totales
    
    @remision.empresa = current_user.empresa
    @remision.sucursal = current_user.sucursal
    
    respond_to do |format|
      if @remision.save
        format.html { redirect_to @remision, notice: 'Remision was successfully created.' }
        format.json { render action: 'show', status: :created, location: @remision }
      else
        format.html { render action: 'new' }
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
    @remision.destroy
    respond_to do |format|
      format.html { redirect_to remisiones_url, notice: 'Remision Eliminada.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_remision
      @remision = current_user.empresa.remisiones.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def remision_params
      params.require(:remision).permit(:cliente_id, :condicionesdepago_id, :formasdepago_id, :metodosdepago_id, :subtotal, :descuento, :total, :totalimpuestosretenidos, :totalimpuestostrasladados, conceptos_attributes: [:id, :cantidad, :unidad, :descripcion, :valorunitario, :importe, :ivatrasladado, :iepstrasladado, :ivaretenido, :isrretenido])
    end
end
