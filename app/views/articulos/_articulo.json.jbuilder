json.extract! articulo, :id, :fecha_ingreso, :modelo_id, :persona_id, :created_at, :updated_at
json.url articulo_url(articulo, format: :json)
