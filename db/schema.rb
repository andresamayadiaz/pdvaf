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

ActiveRecord::Schema.define(version: 20140811205255) do

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
    t.integer  "empresa_id"
    t.string   "telefono"
    t.integer  "listadeprecios_id"
    t.integer  "listadeprecio_id"
  end

  add_index "clientes", ["empresa_id"], name: "index_clientes_on_empresa_id", using: :btree
  add_index "clientes", ["listadeprecio_id"], name: "index_clientes_on_listadeprecio_id", using: :btree
  add_index "clientes", ["listadeprecios_id"], name: "index_clientes_on_listadeprecios_id", using: :btree

  create_table "conceptos", force: true do |t|
    t.decimal  "cantidad",       precision: 10, scale: 4
    t.string   "unidad"
    t.text     "descripcion"
    t.decimal  "valorunitario",  precision: 10, scale: 4
    t.decimal  "importe",        precision: 10, scale: 4
    t.integer  "remision_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "ivatrasladado",  precision: 10, scale: 4
    t.decimal  "iepstrasladado", precision: 10, scale: 4
    t.decimal  "ivaretenido",    precision: 10, scale: 4
    t.decimal  "isrretenido",    precision: 10, scale: 4
    t.string   "codigo"
    t.decimal  "costo",          precision: 10, scale: 4
  end

  add_index "conceptos", ["remision_id"], name: "index_conceptos_on_remision_id", using: :btree

  create_table "condicionesdepagos", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "empresa_id"
  end

  add_index "condicionesdepagos", ["empresa_id"], name: "index_condicionesdepagos_on_empresa_id", using: :btree

  create_table "configuraciones", force: true do |t|
    t.string   "nombre"
    t.string   "valor"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "empresas", force: true do |t|
    t.text     "razonsocial"
    t.string   "rfc"
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
    t.string   "af_user"
    t.string   "af_url"
    t.integer  "clientedefault"
    t.string   "af_logo"
    t.integer  "formapagodefault"
    t.integer  "metodopagodefault"
    t.integer  "condicionpagodefault"
    t.boolean  "ticket"
    t.integer  "decimales",            default: 3
  end

  create_table "formasdepagos", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "empresa_id"
  end

  add_index "formasdepagos", ["empresa_id"], name: "index_formasdepagos_on_empresa_id", using: :btree

  create_table "listadeprecios", force: true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "empresa_id"
  end

  add_index "listadeprecios", ["empresa_id"], name: "index_listadeprecios_on_empresa_id", using: :btree

  create_table "metodosdepagos", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "empresa_id"
  end

  add_index "metodosdepagos", ["empresa_id"], name: "index_metodosdepagos_on_empresa_id", using: :btree

  create_table "monedas", force: true do |t|
    t.string   "nombre"
    t.string   "codigo"
    t.decimal  "tipocambio", precision: 10, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "precios", force: true do |t|
    t.integer  "listadeprecio_id"
    t.integer  "producto_id"
    t.decimal  "precio",           precision: 10, scale: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "productos", force: true do |t|
    t.text     "nombre"
    t.integer  "unidad_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "codigobarras"
    t.decimal  "precio",         precision: 10, scale: 4
    t.decimal  "ivatrasladado",  precision: 10, scale: 0
    t.decimal  "iepstrasladado", precision: 10, scale: 0
    t.decimal  "ivaretenido",    precision: 10, scale: 0
    t.decimal  "isrretenido",    precision: 10, scale: 0
    t.integer  "empresa_id"
  end

  add_index "productos", ["empresa_id"], name: "index_productos_on_empresa_id", using: :btree
  add_index "productos", ["unidad_id"], name: "index_productos_on_unidad_id", using: :btree

  create_table "remisiones", force: true do |t|
    t.integer  "cliente_id"
    t.integer  "condicionesdepago_id"
    t.integer  "formasdepago_id"
    t.integer  "metodosdepago_id"
    t.decimal  "subtotal",                  precision: 10, scale: 4
    t.decimal  "descuento",                 precision: 10, scale: 4
    t.decimal  "total",                     precision: 10, scale: 4
    t.decimal  "totalimpuestosretenidos",   precision: 10, scale: 4
    t.decimal  "totalimpuestostrasladados", precision: 10, scale: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "empresa_id"
    t.integer  "sucursal_id"
    t.boolean  "facturada"
    t.string   "uuid"
    t.string   "af_id"
    t.string   "seriefolio"
    t.text     "pdf_url"
    t.text     "xml_url"
    t.integer  "consecutivo"
    t.integer  "clientefactura_id"
    t.boolean  "cancelada",                                          default: false
    t.datetime "fechacancelacion"
    t.string   "ticket"
    t.boolean  "autoticket",                                         default: false
  end

  add_index "remisiones", ["cliente_id"], name: "index_remisiones_on_cliente_id", using: :btree
  add_index "remisiones", ["condicionesdepago_id"], name: "index_remisiones_on_condicionesdepago_id", using: :btree
  add_index "remisiones", ["empresa_id"], name: "index_remisiones_on_empresa_id", using: :btree
  add_index "remisiones", ["formasdepago_id"], name: "index_remisiones_on_formasdepago_id", using: :btree
  add_index "remisiones", ["metodosdepago_id"], name: "index_remisiones_on_metodosdepago_id", using: :btree
  add_index "remisiones", ["sucursal_id"], name: "index_remisiones_on_sucursal_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "sucursales", force: true do |t|
    t.string   "nombre"
    t.text     "direccion"
    t.string   "telefono"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "empresa_id"
    t.integer  "consecutivo"
    t.string   "af_sucursal"
  end

  add_index "sucursales", ["empresa_id"], name: "index_sucursales_on_empresa_id", using: :btree

  create_table "unidades", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "empresa_id"
  end

  add_index "unidades", ["empresa_id"], name: "index_unidades_on_empresa_id", using: :btree

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
    t.integer  "empresa_id"
    t.integer  "sucursal_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["empresa_id"], name: "index_users_on_empresa_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["sucursal_id"], name: "index_users_on_sucursal_id", using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
