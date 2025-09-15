class Persona < ApplicationRecord
  has_many :articulos, dependent: :nullify
  has_many :transferencias, dependent: :destroy

  def nombre_completo
    "#{nombre} #{apellido}"
  end
end