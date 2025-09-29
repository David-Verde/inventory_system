class HistorialController < ApplicationController
  def index
    authorize :historial, :index?


    @transferencias = Transferencia.includes(articulo: { modelo: :marca }, persona: {}).order(created_at: :desc)


    respond_to do |format|
      format.html


      format.xlsx do
        response.headers["Content-Disposition"] = "attachment; filename=\"historial_transferencias_#{Date.today}.xlsx\""
      end
    end
  end
end
