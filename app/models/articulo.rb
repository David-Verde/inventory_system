class Articulo < ApplicationRecord
  belongs_to :modelo
  belongs_to :persona, optional: true 
  has_many :transferencias, dependent: :destroy
end