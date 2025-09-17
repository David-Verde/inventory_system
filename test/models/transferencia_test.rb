require "test_helper"

class TransferenciaTest < ActiveSupport::TestCase
  test "transfering an articulo should update its current persona and create a history record" do
    marca = Marca.create!(nombre: "TestBrand")
    modelo = Modelo.create!(nombre: "TestModel", marca: marca)
    persona_inicial = Persona.create!(nombre: "Juan", apellido: "Perez")
    persona_nueva = Persona.create!(nombre: "Maria", apellido: "Gomez")

    articulo = Articulo.create!(
      modelo: modelo,
      fecha_ingreso: Date.today,
      persona: persona_inicial
    )
    Transferencia.create!(articulo: articulo, persona: persona_inicial)

    ActiveRecord::Base.transaction do
      articulo.update!(persona: persona_nueva)
      Transferencia.create!(articulo: articulo, persona: persona_nueva)
    end


    articulo.reload

    assert_equal persona_nueva, articulo.persona, "Articulo's current persona was not updated"
    assert_equal 2, articulo.transferencias.count, "A new transfer record was not created"
    assert_equal persona_nueva, articulo.transferencias.last.persona, "The new transfer record does not point to the new persona"
  end
end
