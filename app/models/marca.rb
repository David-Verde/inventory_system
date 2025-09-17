class Marca < ApplicationRecord
  has_many :modelos, dependent: :destroy
  validates :nombre, presence: true, uniqueness: true
end
