require "test_helper"

class MarcaTest < ActiveSupport::TestCase
  test "should not save marca without a name" do
    marca = Marca.new
    assert_not marca.save, "Saved the marca without a name"
  end

  test "should not save marca with a duplicate name" do
    Marca.create(nombre: "Apple")
    marca_duplicada = Marca.new(nombre: "Apple")
    assert_not marca_duplicada.save, "Saved the marca with a duplicate name"
  end

  test "should save marca with a unique name" do
    marca = Marca.new(nombre: "Xiaomi")
    assert marca.save, "Could not save a valid marca"
  end
end