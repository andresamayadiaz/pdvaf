class UnidadesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_unidad, only: [:show, :edit, :update, :destroy]

  # GET /unidades
  # GET /unidades.json
  def index
    @unidades = current_user.empresa.unidades.page params[:page]
  end

  # GET /unidades/1
  # GET /unidades/1.json
  def show
  end

  # GET /unidades/new
  def new
    @unidad = current_user.empresa.unidades.new
  end

  # GET /unidades/1/edit
  def edit
  end

  # POST /unidades
  # POST /unidades.json
  def create
    @unidad = current_user.empresa.unidades.new(unidad_params)

    respond_to do |format|
      if @unidad.save
        format.html { redirect_to @unidad, notice: 'Unidad was successfully created.' }
        format.json { render action: 'show', status: :created, location: @unidad }
      else
        format.html { render action: 'new' }
        format.json { render json: @unidad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /unidades/1
  # PATCH/PUT /unidades/1.json
  def update
    respond_to do |format|
      @unidad.empresa = current_user.empresa
      if @unidad.update(unidad_params)
        format.html { redirect_to @unidad, notice: 'Unidad was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @unidad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /unidades/1
  # DELETE /unidades/1.json
  def destroy
    @unidad.destroy
    respond_to do |format|
      format.html { redirect_to unidades_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unidad
      @unidad = current_user.empresa.unidades.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def unidad_params
      params.require(:unidad).permit(:nombre)
    end
end
