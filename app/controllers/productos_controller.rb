class ProductosController < ApplicationController
  before_action :set_producto, only: [:show, :edit, :update, :destroy]

  # GET /productos
  # GET /productos.json
  def index
    
     if params[:term]
       @productos = Producto.order("nombre ASC").find(:all, :conditions => "productos.codigobarras LIKE '%#{params[:term]}%' OR productos.nombre LIKE '%#{params[:term]}%'")
     else
       @productos = Producto.all
     end
    
     respond_to do |format|  
       format.html # index.html.erb  
       # Here is where you can specify how to handle the request for "/productos.json"
       format.json { render :json => @productos.to_json(:include => :unidad) }
    end
    
  end

  # GET /productos/1
  # GET /productos/1.json
  def show
  end

  # GET /productos/new
  def new
    @producto = Producto.new
    @unidades = Unidad.all
  end

  # GET /productos/1/edit
  def edit
    @unidades = Unidad.all
  end

  # POST /productos
  # POST /productos.json
  def create
    @producto = Producto.new(producto_params)

    respond_to do |format|
      if @producto.save
        format.html { redirect_to @producto, notice: 'Producto was successfully created.' }
        format.json { render action: 'show', status: :created, location: @producto }
      else
        format.html { render action: 'new' }
        format.json { render json: @producto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /productos/1
  # PATCH/PUT /productos/1.json
  def update
    respond_to do |format|
      if @producto.update(producto_params)
        format.html { redirect_to @producto, notice: 'Producto was successfully updated.' }
        format.json { head :no_content }
      else
        @unidades = Unidad.all
        format.html { render action: 'edit' }
        format.json { render json: @producto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /productos/1
  # DELETE /productos/1.json
  def destroy
    @producto.destroy
    respond_to do |format|
      format.html { redirect_to productos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_producto
      @producto = Producto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def producto_params
      params.require(:producto).permit(:nombre, :unidad_id, :codigobarras, :precio)
    end
end
