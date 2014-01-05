class RemisionesController < ApplicationController
  before_action :set_remision, only: [:show, :edit, :update, :destroy]

  # GET /remisiones
  # GET /remisiones.json
  def index
    @remisiones = Remision.all
  end

  # GET /remisiones/1
  # GET /remisiones/1.json
  def show
  end

  # GET /remisiones/new
  def new
    @remision = Remision.new
    @clientes = Cliente.all
    @formasdepago = Formasdepago.all
  end

  # GET /remisiones/1/edit
  def edit
  end

  # POST /remisiones
  # POST /remisiones.json
  def create
    @remision = Remision.new(remision_params)

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
      format.html { redirect_to remisiones_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_remision
      @remision = Remision.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def remision_params
      params.require(:remision).permit(:cliente_id, :condicionesdepago_id, :formasdepago_id, :metodosdepago_id, :subtotal, :descuento, :total, :totalimpuestosretenidos, :totalimpuestostrasladados, :conceptos)
    end
end
