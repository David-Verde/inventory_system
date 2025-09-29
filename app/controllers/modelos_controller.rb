class ModelosController < ApplicationController
  before_action :set_modelo, only: %i[ show edit update destroy ]

  def index
    authorize Modelo
    @modelos = policy_scope(Modelo) 
  end

  def show
    authorize @modelo 
  end

  def new
    @modelo = Modelo.new
    authorize @modelo 
  end

  def edit
    authorize @modelo 
  end

  def create
    @modelo = Modelo.new(modelo_params)
    authorize @modelo 

    respond_to do |format|
      if @modelo.save
        format.html { redirect_to @modelo, notice: "Modelo was successfully created." }
        format.json { render :show, status: :created, location: @modelo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @modelo.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @modelo 
    respond_to do |format|
      if @modelo.update(modelo_params)
        format.html { redirect_to @modelo, notice: "Modelo was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @modelo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @modelo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @modelo 
    @modelo.destroy!

    respond_to do |format|
      format.html { redirect_to modelos_path, notice: "Modelo was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    def set_modelo
      @modelo = Modelo.find(params.expect(:id))
    end

    def modelo_params
      params.expect(modelo: [ :nombre, :marca_id ])
    end
end