class CreateModelos < ActiveRecord::Migration[8.0]
  def change
    create_table :modelos do |t|
      t.string :nombre
      t.references :marca, null: false, foreign_key: true

      t.timestamps
    end
  end
end
