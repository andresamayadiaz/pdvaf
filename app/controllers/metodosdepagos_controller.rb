class MetodosdepagosController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_metodosdepago, only: [:show, :edit, :update, :destroy]

  # GET /metodosdepagos
  # GET /metodosdepagos.json
  def index
    @metodosdepagos = current_user.empresa.metodosdepagos.page params[:page]
  end

  # GET /metodosdepagos/1
  # GET /metodosdepagos/1.json
  def show
  end

  # GET /metodosdepagos/new
  def new
    @metodosdepago = current_user.empresa.metodosdepagos.new
  end

  # GET /metodosdepagos/1/edit
  def edit
  end

  # POST /metodosdepagos
  # POST /metodosdepagos.json
  def create
    @metodosdepago = current_user.empresa.metodosdepagos.new(metodosdepago_params)

    respond_to do |format|
      if @metodosdepago.save
        format.html { redirect_to @metodosdepago, notice: 'Metodosdepago was successfully created.' }
        format.json { render action: 'show', status: :created, location: @metodosdepago }
      else
        format.html { render action: 'new' }
        format.json { render json: @metodosdepago.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /metodosdepagos/1
  # PATCH/PUT /metodosdepagos/1.json
  def update
    respond_to do |format|
      @metodosdepago.empresa = current_user.empresa
      if @metodosdepago.update(metodosdepago_params)
        format.html { redirect_to @metodosdepago, notice: 'Metodosdepago was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @metodosdepago.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /metodosdepagos/1
  # DELETE /metodosdepagos/1.json
  def destroy
    @metodosdepago.destroy
    respond_to do |format|
      format.html { redirect_to metodosdepagos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_metodosdepago
      @metodosdepago = current_user.empresa.metodosdepagos.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def metodosdepago_params
      params.require(:metodosdepago).permit(:nombre)
    end
end
