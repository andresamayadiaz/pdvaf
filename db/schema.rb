# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140107005934) do

  create_table "clientes", force: true do |t|
    t.string   "rfc"
    t.text     "nombre"
    t.string   "email"
    t.string   "noExterior"
    t.string   "noInterior"
    t.string   "calle"
    t.string   "colonia"
    t.string   "municipio"
    t.string   "estado"
    t.string   "pais"
    t.string   "codigoPostal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conceptos", force: true do |t|
    t.decimal  "cantidad"
    t.string   "unidad"
    t.text     "descripcion"
    t.decimal  "valorunitario"
    t.decimal  "importe"
    t.integer  "remision_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conceptos", ["remision_id"], name: "index_conceptos_on_remision_id"

  create_table "condicionesdepagos", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "configuraciones", force: true do |t|
    t.string   "nombre"
    t.string   "valor"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "formasdepagos", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "metodosdepagos", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "monedas", force: true do |t|
    t.string   "nombre"
    t.string   "codigo"
    t.decimal  "tipocambio"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "precios", force: true do |t|
    t.integer  "producto_id"
    t.integer  "moneda_id"
    t.decimal  "precio"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "precios", ["moneda_id"], name: "index_precios_on_moneda_id"
  add_index "precios", ["producto_id", "moneda_id"], name: "index_precios_on_producto_id_and_moneda_id", unique: true
  add_index "precios", ["producto_id"], name: "index_precios_on_producto_id"

  create_table "productos", force: true do |t|
    t.text     "nombre"
    t.integer  "unidad_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "codigobarras"
    t.decimal  "precio"
  end

  add_index "productos", ["unidad_id"], name: "index_productos_on_unidad_id"

  create_table "remisiones", force: true do |t|
    t.integer  "cliente_id"
    t.integer  "condicionesdepago_id"
    t.integer  "formasdepago_id"
    t.integer  "metodosdepago_id"
    t.decimal  "subtotal"
    t.decimal  "descuento"
    t.decimal  "total"
    t.decimal  "totalimpuestosretenidos"
    t.decimal  "totalimpuestostrasladados"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "remisiones", ["cliente_id"], name: "index_remisiones_on_cliente_id"
  add_index "remisiones", ["condicionesdepago_id"], name: "index_remisiones_on_condicionesdepago_id"
  add_index "remisiones", ["formasdepago_id"], name: "index_remisiones_on_formasdepago_id"
  add_index "remisiones", ["metodosdepago_id"], name: "index_remisiones_on_metodosdepago_id"

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "unidades", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end