class ClientesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_cliente, only: [:show, :edit, :update, :destroy]
  
  def import
    Cliente.import(params[:file], current_user.empresa)
    redirect_to clientes_url, notice: "Clientes Importados."
  end
  
  # GET /clientes
  # GET /clientes.json
  def index
    
    if params[:search]
      keyword = params[:q]
      @clientes = current_user.empresa.clientes.where("rfc LIKE ? OR nombre LIKE ?", "%#{keyword}%", "%#{keyword}%").page params[:page]
    elsif params[:searchall]
      @clientes = current_user.empresa.clientes.all
    else
      @clientes = current_user.empresa.clientes.page params[:page]
    end
    
    cookies[:current_page] = params[:page]
    
  end
  
  # GET /clientes/1
  # GET /clientes/1.json
  def show
  end

  # GET /clientes/new
  def new
    
    @cliente = current_user.empresa.clientes.new
    @listadeprecios = current_user.empresa.listadeprecios.load
    
  end

  # GET /clientes/1/edit
  def edit
    
    @listadeprecios = current_user.empresa.listadeprecios.load
    
  end

  # POST /clientes
  # POST /clientes.json
  def create
    @cliente = current_user.empresa.clientes.new(cliente_params)
    @listadeprecios = current_user.empresa.listadeprecios.load

    respond_to do |format|
      if @cliente.save
        format.html { redirect_to @cliente, notice: 'Cliente was successfully created.' }
        format.json { render action: 'show', status: :created, location: @cliente }
      else
        format.html { render action: 'new' }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /clientes/1
  # PATCH/PUT /clientes/1.json
  def update
    respond_to do |format|
      if @cliente.update(cliente_params)
        format.html { redirect_to clientes_url({:page => cookies[:current_page]}), notice: 'Cliente was successfully updated.' }
        format.json { head :no_content }
      else
        @listadeprecios = current_user.empresa.listadeprecios.load
        format.html { render action: 'edit' }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clientes/1
  # DELETE /clientes/1.json
  def destroy
    @cliente.destroy
    respond_to do |format|
      format.html { redirect_to clientes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cliente
      @cliente = current_user.empresa.clientes.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cliente_params
      params.require(:cliente).permit(:rfc, :nombre, :email, :noExterior, :noInterior, :calle, :colonia, :municipio, :estado, :pais, :codigoPostal, :telefono, :listadeprecio_id)
    end
end
