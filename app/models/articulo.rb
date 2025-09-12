class Articulo < ApplicationRecord
  belongs_to :modelo
  belongs_to :persona, optional: true # Un artículo puede no tener portador
  has_many :transferencias, dependent: :destroy
end