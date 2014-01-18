class EmpresasController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_empresa, only: [:show, :edit, :update, :destroy]
  
  # GET /empresas
  # GET /empresas.json
  def index
    @empresas = current_user.empresa
  end

  # GET /empresas/1
  # GET /empresas/1.json
  def show
  end

  # GET /empresas/new
  def new
    @empresa = current_user.empresa.new
  end

  # GET /empresas/1/edit
  def edit
  end

  # POST /empresas
  # POST /empresas.json
  def create
    @empresa = current_user.empresa.new(empresa_params)

    respond_to do |format|
      if @empresa.save
        format.html { redirect_to @empresa, notice: 'Empresa was successfully created.' }
        format.json { render action: 'show', status: :created, location: @empresa }
      else
        format.html { render action: 'new' }
        format.json { render json: @empresa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /empresas/1
  # PATCH/PUT /empresas/1.json
  def update
    respond_to do |format|
      if @empresa.update(empresa_params)
        format.html { redirect_to @empresa, notice: 'Empresa was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @empresa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /empresas/1
  # DELETE /empresas/1.json
  def destroy
    @empresa.destroy
    respond_to do |format|
      format.html { redirect_to empresas_url }
      format.json { head :no_content }
    end
  end
  
  def newuser
    @user = current_user.empresa.users.new
    @sucursales = current_user.empresa.sucursales.all
  end
  
  def createuser
    params.permit!
    @user = current_user.empresa.users.new(params[:user])
    @user.add_role :empleado
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Usuario Creado.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_empresa
      #@empresa = current_user.empresa.find(params[:id])
      @empresa = current_user.empresa
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def empresa_params
      params.require(:empresa).permit(:razonsocial, :rfc, :noExterior, :noInterior, :calle, :colonia, :municipio, :estado, :pais, :codigoPostal, :af_user, :af_url)
    end
end
