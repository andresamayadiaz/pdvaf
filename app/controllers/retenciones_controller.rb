class RetencionesController < ApplicationController
  before_action :set_retencion, only: [:show, :edit, :update, :destroy]

  # GET /retenciones
  # GET /retenciones.json
  def index
    @retenciones = Retencion.all
  end

  # GET /retenciones/1
  # GET /retenciones/1.json
  def show
  end

  # GET /retenciones/new
  def new
    @retencion = Retencion.new
  end

  # GET /retenciones/1/edit
  def edit
  end

  # POST /retenciones
  # POST /retenciones.json
  def create
    @retencion = Retencion.new(retencion_params)

    respond_to do |format|
      if @retencion.save
        format.html { redirect_to @retencion, notice: 'Retencion was successfully created.' }
        format.json { render action: 'show', status: :created, location: @retencion }
      else
        format.html { render action: 'new' }
        format.json { render json: @retencion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /retenciones/1
  # PATCH/PUT /retenciones/1.json
  def update
    respond_to do |format|
      if @retencion.update(retencion_params)
        format.html { redirect_to @retencion, notice: 'Retencion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @retencion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /retenciones/1
  # DELETE /retenciones/1.json
  def destroy
    @retencion.destroy
    respond_to do |format|
      format.html { redirect_to retenciones_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_retencion
      @retencion = Retencion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def retencion_params
      params.require(:retencion).permit(:tipo, :nombre, :tasa)
    end
end
