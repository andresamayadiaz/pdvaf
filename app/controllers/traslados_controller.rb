class TrasladosController < ApplicationController
  before_action :set_traslado, only: [:show, :edit, :update, :destroy]

  # GET /traslados
  # GET /traslados.json
  def index
    @traslados = Traslado.all
  end

  # GET /traslados/1
  # GET /traslados/1.json
  def show
  end

  # GET /traslados/new
  def new
    @traslado = Traslado.new
  end

  # GET /traslados/1/edit
  def edit
  end

  # POST /traslados
  # POST /traslados.json
  def create
    @traslado = Traslado.new(traslado_params)

    respond_to do |format|
      if @traslado.save
        format.html { redirect_to @traslado, notice: 'Traslado was successfully created.' }
        format.json { render action: 'show', status: :created, location: @traslado }
      else
        format.html { render action: 'new' }
        format.json { render json: @traslado.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /traslados/1
  # PATCH/PUT /traslados/1.json
  def update
    respond_to do |format|
      if @traslado.update(traslado_params)
        format.html { redirect_to @traslado, notice: 'Traslado was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @traslado.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /traslados/1
  # DELETE /traslados/1.json
  def destroy
    @traslado.destroy
    respond_to do |format|
      format.html { redirect_to traslados_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_traslado
      @traslado = Traslado.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def traslado_params
      params.require(:traslado).permit(:tipo, :nombre, :tasa)
    end
end
