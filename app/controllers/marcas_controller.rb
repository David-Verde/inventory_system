class MarcasController < ApplicationController
  before_action :set_marca, only: %i[ show edit update destroy ]

  def index
    authorize Marca
    @marcas = policy_scope(Marca)
  end

  def show
    authorize @marca 
  end

  def new
    @marca = Marca.new
    authorize @marca 
  end

  def edit
    authorize @marca 
  end

  def create
    @marca = Marca.new(marca_params)
    authorize @marca

    respond_to do |format|
      if @marca.save
        format.html { redirect_to @marca, notice: "Marca was successfully created." }
        format.json { render :show, status: :created, location: @marca }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @marca.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @marca 
    respond_to do |format|
      if @marca.update(marca_params)
        format.html { redirect_to @marca, notice: "Marca was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @marca }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @marca.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @marca 
    @marca.destroy!

    respond_to do |format|
      format.html { redirect_to marcas_path, notice: "Marca was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    def set_marca
      @marca = Marca.find(params.expect(:id))
    end

    def marca_params
      params.expect(marca: [ :nombre ])
    end
end