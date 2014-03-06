class ListadepreciosController < ApplicationController
  before_action :set_listadeprecio, only: [:show, :edit, :update, :destroy]

  # GET /listadeprecios
  # GET /listadeprecios.json
  def index
    @listadeprecios = current_user.empresa.listadeprecios.all
  end

  # GET /listadeprecios/1
  # GET /listadeprecios/1.json
  def show
  end

  # GET /listadeprecios/new
  def new
    @listadeprecio = current_user.empresa.listadeprecios.new
  end

  # GET /listadeprecios/1/edit
  def edit
  end

  # POST /listadeprecios
  # POST /listadeprecios.json
  def create
    @listadeprecio = current_user.empresa.listadeprecios.new(listadeprecio_params)

    respond_to do |format|
      if @listadeprecio.save
        format.html { redirect_to @listadeprecio, notice: 'Listadeprecio was successfully created.' }
        format.json { render action: 'show', status: :created, location: @listadeprecio }
      else
        format.html { render action: 'new' }
        format.json { render json: @listadeprecio.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /listadeprecios/1
  # PATCH/PUT /listadeprecios/1.json
  def update
    respond_to do |format|
      @listadeprecio.empresa = current_user.empresa
      if @listadeprecio.update(listadeprecio_params)
        format.html { redirect_to @listadeprecio, notice: 'Listadeprecio was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @listadeprecio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listadeprecios/1
  # DELETE /listadeprecios/1.json
  def destroy
    @listadeprecio.destroy
    respond_to do |format|
      format.html { redirect_to listadeprecios_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listadeprecio
      @listadeprecio = current_user.empresa.listadeprecios.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listadeprecio_params
      params.require(:listadeprecio).permit(:nombre, :descripcion)
    end
end
