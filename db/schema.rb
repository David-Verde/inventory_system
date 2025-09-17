# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_09_16_180847) do
  create_table "articulos", force: :cascade do |t|
    t.date "fecha_ingreso"
    t.integer "modelo_id", null: false
    t.integer "persona_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["modelo_id"], name: "index_articulos_on_modelo_id"
    t.index ["persona_id"], name: "index_articulos_on_persona_id"
  end

  create_table "marcas", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "modelos", force: :cascade do |t|
    t.string "nombre"
    t.integer "marca_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["marca_id"], name: "index_modelos_on_marca_id"
  end

  create_table "personas", force: :cascade do |t|
    t.string "nombre"
    t.string "apellido"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transferencias", force: :cascade do |t|
    t.integer "articulo_id", null: false
    t.integer "persona_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["articulo_id"], name: "index_transferencias_on_articulo_id"
    t.index ["persona_id"], name: "index_transferencias_on_persona_id"
  end

  add_foreign_key "articulos", "modelos"
  add_foreign_key "articulos", "personas"
  add_foreign_key "modelos", "marcas"
  add_foreign_key "transferencias", "articulos"
  add_foreign_key "transferencias", "personas"
end
