class ProductImporterService
  include HTTParty

  BASE_URI = "https://openrouter.ai/api/v1"

  def initialize(image_file)
    @image_file = image_file
    @api_key = ENV["OPENROUTER_API_KEY"]
  end

  def call
    if @api_key.blank?
      return { success: false, message: "La API Key de OpenRouter no está configurada. Asegúrate de tener un archivo .env con OPENROUTER_API_KEY." }
    end

    return { success: false, message: "Por favor, sube un archivo de imagen válido." } unless valid_image?

    base64_image = Base64.strict_encode64(@image_file.read)
    content_type = @image_file.content_type

    headers = {
      "Authorization" => "Bearer #{@api_key}",
      "Content-Type" => "application/json"
    }

    body = {
      model: "openai/gpt-4o",
      max_tokens: 150,
      messages: [
        {
          role: "user",
          content: [
            {
              type: "text",
              text: "Analiza la siguiente imagen de una página de producto. Extrae la MARCA y el MODELO del producto. Responde únicamente con un JSON con las claves 'marca' y 'modelo'. Por ejemplo: {\"marca\": \"Apple\", \"modelo\": \"MacBook Air M1 Chip 13-pulgadas\"}. Si no puedes determinar alguno, responde con un valor nulo. NO incluyas explicaciones ni texto adicional."
            },
            {
              type: "image_url",
              image_url: {
                url: "data:#{content_type};base64,#{base64_image}"
              }
            }
          ]
        }
      ]
    }.to_json

    response = self.class.post("#{BASE_URI}/chat/completions", headers: headers, body: body)

    if response.success?
      parsed_response = JSON.parse(response.body)
      ai_content = parsed_response.dig("choices", 0, "message", "content")

      Rails.logger.info "Raw AI Response: #{ai_content}"

      json_match = ai_content.match(/{.*}/m)

      if json_match
        product_data = JSON.parse(json_match[0])
        { success: true, data: product_data }
      else
        raise JSON::ParserError
      end

    else
      error_details = response.body
      Rails.logger.error "OpenRouter API Error: #{error_details}"
      { success: false, message: "Error al comunicarse con la IA: #{response.message}. Detalles: #{error_details}" }
    end

  rescue JSON::ParserError
    { success: false, message: "La IA devolvió una respuesta en un formato inesperado." }
  rescue => e
    { success: false, message: "Ocurrió un error inesperado: #{e.message}" }
  end

  private

  def valid_image?
    @image_file.present? && @image_file.content_type.start_with?("image/")
  end
end
