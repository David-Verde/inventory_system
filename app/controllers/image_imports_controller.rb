class ImageImportsController < ApplicationController
  def create
    image = params[:image]
    result = ProductImporterService.new(image).call

    unless result[:success]
      redirect_to modelos_path, alert: result[:message]
      return
    end

    marca_nombre = result.dig(:data, "marca")&.strip
    modelo_nombre_candidato = result.dig(:data, "modelo")&.strip

    if marca_nombre.blank? || modelo_nombre_candidato.blank?
      redirect_to modelos_path, alert: "La IA no pudo extraer la marca o el modelo de la imagen."
      return
    end

    begin
      ActiveRecord::Base.transaction do
        marca = Marca.find_or_create_by!(nombre: marca_nombre)

        nombre_normalizado_candidato = normalize_name(modelo_nombre_candidato)

        modelo_existente_similar = marca.modelos.find do |modelo|
          nombre_normalizado_existente = normalize_name(modelo.nombre)
          nombre_normalizado_existente.include?(nombre_normalizado_candidato) ||
          nombre_normalizado_candidato.include?(nombre_normalizado_existente)
        end

        if modelo_existente_similar
          redirect_to modelos_path, notice: "¡Información detectada! El modelo '#{modelo_nombre_candidato}' es muy similar al modelo ya existente '#{modelo_existente_similar.nombre}'. No se ha creado un duplicado."
        else
          marca.modelos.create!(nombre: modelo_nombre_candidato)
          redirect_to modelos_path, notice: "¡Éxito! Se ha creado el modelo '#{modelo_nombre_candidato}' para la marca '#{marca.nombre}'."
        end
      end
    rescue ActiveRecord::RecordInvalid => e
      redirect_to modelos_path, alert: "No se pudo guardar la información: #{e.message}"
    end
  end

  private

  def normalize_name(name)
    name.to_s.downcase.gsub(/\s+/, " ").strip
  end
end
