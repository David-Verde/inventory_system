class CreateArticulos < ActiveRecord::Migration[8.0]
  def change
    create_table :articulos do |t|
      t.date :fecha_ingreso
      t.references :modelo, null: false, foreign_key: true
      t.references :persona, null: false, foreign_key: true

      t.timestamps
    end
  end
end
