class ProductosController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_producto, only: [:show, :edit, :update, :destroy]

  def import
    Producto.import(params[:file], current_user.empresa)
    redirect_to productos_url, notice: "Productos Importados."
  end

  # GET /productos
  # GET /productos.json
  def index

     if params[:term] && !params[:codbarras]
       @productos = current_user.empresa.productos.where("nombre LIKE '%#{params[:term]}%'").page params[:page]
     elsif params[:term] && params[:codbarras]
         @productos = current_user.empresa.productos.where("codigobarras LIKE '%#{params[:term]}%'").page params[:page]
     else
       @productos = current_user.empresa.productos.page params[:page]
     end

     cookies[:current_page] = params[:page]

     respond_to do |format|
       format.html # index.html.erb
       # Here is where you can specify how to handle the request for "/productos.json"
       logger.debug @productos.to_json(:include => [:unidad, :precios])
       format.json { render :json => @productos.to_json(:include => [:unidad, :precios]) }
    end

  end

  def

  # GET /productos/1
  # GET /productos/1.json
  def show
  end

  # GET /productos/new
  def new

    @producto = current_user.empresa.productos.new
    authorize! :create, @producto

    @unidades = current_user.empresa.unidades.load
    @listadeprecios = current_user.empresa.listadeprecios.load

    # Validate
    if @unidades.size <= 0
      redirect_to unidades_path, alert: 'Debes tener al menos una Unidad.'
    end

  end

  # GET /productos/1/edit
  def edit

    logger.debug "----------------------------"
    logger.debug params
    logger.debug "----------------------------"

    authorize! :edit, @producto

    @unidades = current_user.empresa.unidades.load
    @listadeprecios = current_user.empresa.listadeprecios.load

  end

  # POST /productos
  # POST /productos.json
  def create
    @producto = current_user.empresa.productos.new(producto_params)

    authorize! :create, @producto

    respond_to do |format|
      if @producto.save
        format.html { redirect_to @producto, notice: 'Producto was successfully created.' }
        format.json { render action: 'show', status: :created, location: @producto }
      else
        @unidades = current_user.empresa.unidades.load
        @listadeprecios = current_user.empresa.listadeprecios.load
        format.html { render action: 'new' }
        format.json { render json: @producto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /productos/1
  # PATCH/PUT /productos/1.json
  def update

    authorize! :update, @producto

    respond_to do |format|
      if @producto.update(producto_params)
        format.html { redirect_to productos_url({:page => cookies[:current_page]}), notice: 'Producto was successfully updated.' }
        format.json { head :no_content }
      else
        @unidades = current_user.empresa.unidades.load
        @listadeprecios = current_user.empresa.listadeprecios.load
        format.html { render action: 'edit' }
        format.json { render json: @producto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /productos/1
  # DELETE /productos/1.json
  def destroy

    authorize! :destroy, @producto

    @producto.destroy
    respond_to do |format|
      format.html { redirect_to productos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_producto
      @producto = current_user.empresa.productos.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def producto_params
      params.require(:producto).permit(:nombre, :unidad_id, :codigobarras, :precio, :ivatrasladado, :iepstrasladado, :ivaretenido, :isrretenido, precios_attributes: [:id, :producto, :listadeprecio_id, :precio])
    end
end
