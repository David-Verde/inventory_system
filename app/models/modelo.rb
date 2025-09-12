class Modelo < ApplicationRecord
  belongs_to :marca
  has_many :articulos, dependent: :destroy
  validates :nombre, presence: true
end