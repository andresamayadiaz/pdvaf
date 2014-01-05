class ConceptosController < ApplicationController
  before_action :set_concepto, only: [:show, :edit, :update, :destroy]

  # GET /conceptos
  # GET /conceptos.json
  def index
    @conceptos = Concepto.all
  end

  # GET /conceptos/1
  # GET /conceptos/1.json
  def show
  end

  # GET /conceptos/new
  def new
    @concepto = Concepto.new
  end

  # GET /conceptos/1/edit
  def edit
  end

  # POST /conceptos
  # POST /conceptos.json
  def create
    @concepto = Concepto.new(concepto_params)

    respond_to do |format|
      if @concepto.save
        format.html { redirect_to @concepto, notice: 'Concepto was successfully created.' }
        format.json { render action: 'show', status: :created, location: @concepto }
      else
        format.html { render action: 'new' }
        format.json { render json: @concepto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conceptos/1
  # PATCH/PUT /conceptos/1.json
  def update
    respond_to do |format|
      if @concepto.update(concepto_params)
        format.html { redirect_to @concepto, notice: 'Concepto was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @concepto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conceptos/1
  # DELETE /conceptos/1.json
  def destroy
    @concepto.destroy
    respond_to do |format|
      format.html { redirect_to conceptos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_concepto
      @concepto = Concepto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def concepto_params
      params.require(:concepto).permit(:cantidad, :unidad, :descripcion, :valorunitario, :importe, :remision_id)
    end
end
