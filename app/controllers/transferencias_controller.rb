class TransferenciasController < ApplicationController
  before_action :set_articulo

  def new
    @transferencia = @articulo.transferencias.new
    @personas = Persona.all
  end

  def create
    @transferencia = @articulo.transferencias.new(transferencia_params)

    ActiveRecord::Base.transaction do
      @articulo.update!(persona_id: @transferencia.persona_id)
      @transferencia.save!
    end

    redirect_to @articulo, notice: "Artículo transferido con éxito."
  rescue ActiveRecord::RecordInvalid
    @personas = Persona.all
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
