class TransferenciasController < ApplicationController
  before_action :set_articulo

  def new
    @transferencia = @articulo.transferencias.new
    @personas = Persona.all
  end

  def create
    nueva_persona = Persona.find(transferencia_params[:persona_id])
    
    ActiveRecord::Base.transaction do
      Transferencia.create!(
        articulo: @articulo,
        persona: nueva_persona
      )

      @articulo.update!(persona: nueva_persona)
    end

    redirect_to @articulo, notice: "Artículo transferido con éxito a #{nueva_persona.nombre_completo}."
  rescue ActiveRecord::RecordInvalid => e
    @personas = Persona.all
    flash.now[:alert] = "No se pudo realizar la transferencia: #{e.message}"
    render :new, status: :unprocessable_entity
  rescue ActiveRecord::RecordNotFound
    @personas = Persona.all
    flash.now[:alert] = "La persona seleccionada no es válida."
    render :new, status: :unprocessable_entity
  end

  private

  def set_articulo
    @articulo = Articulo.find(params[:articulo_id])
  end

  def transferencia_params
    params.require(:transferencia).permit(:persona_id)
  end
end