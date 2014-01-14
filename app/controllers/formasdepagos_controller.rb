class FormasdepagosController < ApplicationController
  before_action :set_formasdepago, only: [:show, :edit, :update, :destroy]

  # GET /formasdepagos
  # GET /formasdepagos.json
  def index
    @formasdepagos = current_user.empresa.formasdepagos.page params[:page]
  end

  # GET /formasdepagos/1
  # GET /formasdepagos/1.json
  def show
  end

  # GET /formasdepagos/new
  def new
    @formasdepago = current_user.empresa.formasdepagos.new
  end

  # GET /formasdepagos/1/edit
  def edit
  end

  # POST /formasdepagos
  # POST /formasdepagos.json
  def create
    @formasdepago = current_user.empresa.formasdepagos.new(formasdepago_params)

    respond_to do |format|
      if @formasdepago.save
        format.html { redirect_to @formasdepago, notice: 'Formasdepago was successfully created.' }
        format.json { render action: 'show', status: :created, location: @formasdepago }
      else
        format.html { render action: 'new' }
        format.json { render json: @formasdepago.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /formasdepagos/1
  # PATCH/PUT /formasdepagos/1.json
  def update
    respond_to do |format|
      @formasdepago.empresa = current_user.empresa
      if @formasdepago.update(formasdepago_params)
        format.html { redirect_to @formasdepago, notice: 'Formasdepago was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @formasdepago.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /formasdepagos/1
  # DELETE /formasdepagos/1.json
  def destroy
    @formasdepago.destroy
    respond_to do |format|
      format.html { redirect_to formasdepagos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_formasdepago
      @formasdepago = Formasdepago.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def formasdepago_params
      params.require(:formasdepago).permit(:nombre)
    end
end
