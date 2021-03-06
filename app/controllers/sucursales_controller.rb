class SucursalesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_sucursal, only: [:show, :edit, :update, :destroy]

  # GET /sucursales
  # GET /sucursales.json
  def index
    @sucursales = current_user.empresa.sucursales.all
  end

  # GET /sucursales/1
  # GET /sucursales/1.json
  def show
  end

  # GET /sucursales/new
  def new
    @sucursal = current_user.empresa.sucursales.new
  end

  # GET /sucursales/1/edit
  def edit
  end

  # POST /sucursales
  # POST /sucursales.json
  def create
    @sucursal = current_user.empresa.sucursales.new(sucursal_params)

    respond_to do |format|
      if @sucursal.save
        format.html { redirect_to @sucursal, notice: 'Sucursal was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sucursal }
      else
        format.html { render action: 'new' }
        format.json { render json: @sucursal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sucursales/1
  # PATCH/PUT /sucursales/1.json
  def update
    respond_to do |format|
      if @sucursal.update(sucursal_params)
        format.html { redirect_to @sucursal, notice: 'Sucursal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sucursal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sucursales/1
  # DELETE /sucursales/1.json
  def destroy
    @sucursal.destroy
    respond_to do |format|
      format.html { redirect_to sucursales_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sucursal
      @sucursal = current_user.empresa.sucursales.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sucursal_params
      params.require(:sucursal).permit(:nombre, :direccion, :telefono, :email, :af_sucursal)
    end
end
