class CondicionesdepagosController < ApplicationController
  before_action :set_condicionesdepago, only: [:show, :edit, :update, :destroy]

  # GET /condicionesdepagos
  # GET /condicionesdepagos.json
  def index
    @condicionesdepagos = current_user.empresa.condicionesdepagos.page params[:page]
  end

  # GET /condicionesdepagos/1
  # GET /condicionesdepagos/1.json
  def show
  end

  # GET /condicionesdepagos/new
  def new
    @condicionesdepago = current_user.empresa.condicionesdepagos.new
  end

  # GET /condicionesdepagos/1/edit
  def edit
  end

  # POST /condicionesdepagos
  # POST /condicionesdepagos.json
  def create
    @condicionesdepago = Condicionesdepago.new(condicionesdepago_params)
    @condicionesdepago.empresa = current_user.empresa

    respond_to do |format|
      if @condicionesdepago.save
        format.html { redirect_to @condicionesdepago, notice: 'Condicionesdepago was successfully created.' }
        format.json { render action: 'show', status: :created, location: @condicionesdepago }
      else
        format.html { render action: 'new' }
        format.json { render json: @condicionesdepago.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /condicionesdepagos/1
  # PATCH/PUT /condicionesdepagos/1.json
  def update
    respond_to do |format|
      @condicionesdepago.empresa = current_user.empresa
      if @condicionesdepago.update(condicionesdepago_params)
        format.html { redirect_to @condicionesdepago, notice: 'Condicionesdepago was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @condicionesdepago.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /condicionesdepagos/1
  # DELETE /condicionesdepagos/1.json
  def destroy
    @condicionesdepago.destroy
    respond_to do |format|
      format.html { redirect_to condicionesdepagos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_condicionesdepago
      @condicionesdepago = Condicionesdepago.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def condicionesdepago_params
      params.require(:condicionesdepago).permit(:nombre)
    end
end
