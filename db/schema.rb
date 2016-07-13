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

ActiveRecord::Schema.define(version: 20160713041856) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agenda", primary_key: "id_agenda", force: :cascade do |t|
    t.integer "id_centrosalud", null: false
    t.integer "id_persona",     null: false
    t.date    "fecha_agenda",   null: false
  end

  add_index "agenda", ["id_agenda"], name: "agenda_pk", unique: true, using: :btree
  add_index "agenda", ["id_centrosalud"], name: "centro_tiene_agendas_fk", using: :btree
  add_index "agenda", ["id_persona"], name: "medico_tiene_agendas_fk", using: :btree

  create_table "bloque", primary_key: "id_bloque", force: :cascade do |t|
    t.integer "id_agenda",          null: false
    t.time    "hora_inicio_bloque", null: false
    t.time    "hora_fin_bloque",    null: false
  end

  add_index "bloque", ["id_agenda"], name: "agenda_tiene_bloques_fk", using: :btree
  add_index "bloque", ["id_bloque"], name: "bloque_pk", unique: true, using: :btree

  create_table "centro_de_salud", primary_key: "id_centrosalud", force: :cascade do |t|
    t.integer "id_tipocentro",                null: false
    t.integer "id_comuna",                    null: false
    t.string  "nombre_centro",     limit: 32, null: false
    t.string  "direccion_centro",  limit: 25, null: false
    t.integer "numero_centro",     limit: 2,  null: false
    t.string  "email_centro",      limit: 20
    t.string  "pagina_web_centro", limit: 30
  end

  add_index "centro_de_salud", ["id_centrosalud"], name: "centro_de_salud_pk", unique: true, using: :btree
  add_index "centro_de_salud", ["id_comuna"], name: "centro_esta_en_comuna_fk", using: :btree
  add_index "centro_de_salud", ["id_tipocentro"], name: "centro_pertenece_tipocentro_fk", using: :btree

  create_table "cita", primary_key: "id_cita", force: :cascade do |t|
    t.integer "id_bloque",                   null: false
    t.integer "id_estadocita",               null: false
    t.integer "id_persona",                  null: false
    t.time    "hora_llegada"
    t.integer "box_atencion_cita", limit: 2
  end

  add_index "cita", ["id_bloque"], name: "bloque_tiene_citas_fk", using: :btree
  add_index "cita", ["id_cita"], name: "cita_pk", unique: true, using: :btree
  add_index "cita", ["id_estadocita"], name: "cita_tiene_estado_fk", using: :btree
  add_index "cita", ["id_persona"], name: "paciente_tiene_cita_fk", using: :btree

  create_table "comuna", primary_key: "id_comuna", force: :cascade do |t|
    t.string "nombre_comuna", limit: 20, null: false
  end

  add_index "comuna", ["id_comuna"], name: "comuna_pk", unique: true, using: :btree

  create_table "especialidad", primary_key: "id_especialidad", force: :cascade do |t|
    t.string "nombre_especialidad", limit: 20, null: false
  end

  add_index "especialidad", ["id_especialidad"], name: "especialidad_pk", unique: true, using: :btree

  create_table "especialidades_medico", id: false, force: :cascade do |t|
    t.integer "id_especialidad", null: false
    t.integer "id_persona",      null: false
  end

  add_index "especialidades_medico", ["id_especialidad"], name: "espmedico_son_esp_fk", using: :btree
  add_index "especialidades_medico", ["id_persona"], name: "medico_tiene_especialidad_fk", using: :btree

  create_table "estado_cita", primary_key: "id_estadocita", force: :cascade do |t|
    t.string "nombre_estadocita", limit: 15, null: false
  end

  add_index "estado_cita", ["id_estadocita"], name: "estado_cita_pk", unique: true, using: :btree

  create_table "funcionario", primary_key: "id_persona", force: :cascade do |t|
    t.integer "id_centrosalud", null: false
  end

  add_index "funcionario", ["id_centrosalud"], name: "func_trabaja_en_centro_fk", using: :btree
  add_index "funcionario", ["id_persona"], name: "funcionario_pk", unique: true, using: :btree

  create_table "medico", primary_key: "id_persona", force: :cascade do |t|
  end

  add_index "medico", ["id_persona"], name: "medico_pk", unique: true, using: :btree

  create_table "paciente", primary_key: "id_persona", force: :cascade do |t|
    t.integer "id_comuna",                            null: false
    t.date    "fecha_nacimiento_paciente",            null: false
    t.integer "sexo_paciente",             limit: 2,  null: false
    t.string  "direccion_paciente",        limit: 25, null: false
    t.integer "numero_paciente",           limit: 2,  null: false
    t.integer "dpto_paciente",             limit: 2
    t.string  "email_paciente",            limit: 20
    t.string  "prevision_paciente",        limit: 20, null: false
  end

  add_index "paciente", ["id_comuna"], name: "paciente_vive_en_comuna_fk", using: :btree
  add_index "paciente", ["id_persona"], name: "paciente_pk", unique: true, using: :btree

  create_table "persona", primary_key: "id_persona", force: :cascade do |t|
    t.integer "id_rol"
    t.string  "nombre_persona",    limit: 20, null: false
    t.string  "apellidop_persona", limit: 15, null: false
    t.string  "apellidom_persona", limit: 15, null: false
    t.integer "run_persona",                  null: false
    t.integer "codigo_persona",    limit: 2,  null: false
  end

  add_index "persona", ["id_persona"], name: "persona_pk", unique: true, using: :btree
  add_index "persona", ["id_rol"], name: "persona_tiene_rol_fk", using: :btree

  create_table "rol", primary_key: "id_rol", force: :cascade do |t|
    t.string "nombre_rol", limit: 16, null: false
    t.string "clave_rol",  limit: 20, null: false
  end

  add_index "rol", ["id_rol"], name: "rol_pk", unique: true, using: :btree

  create_table "rols", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "run"
    t.integer  "run_dig_ver"
    t.string   "nombre"
    t.string   "apellidop"
    t.string   "apellidom"
    t.datetime "fecha_nacimiento"
    t.string   "nombre_rol"
    t.string   "prevision"
    t.integer  "sexo"
    t.string   "direccion"
    t.integer  "num"
    t.integer  "depto"
    t.integer  "comuna"
    t.integer  "telefono"
  end

  add_index "rols", ["email"], name: "index_rols_on_email", unique: true, using: :btree
  add_index "rols", ["reset_password_token"], name: "index_rols_on_reset_password_token", unique: true, using: :btree

  create_table "telefono", primary_key: "id_telefono", force: :cascade do |t|
    t.integer "id_centrosalud"
    t.integer "id_persona"
    t.integer "num_telefono",              null: false
    t.string  "tipo_telefono",  limit: 15, null: false
  end

  add_index "telefono", ["id_centrosalud"], name: "centro_tiene_telefono_fk", using: :btree
  add_index "telefono", ["id_persona"], name: "persona_tiene_telefono_fk", using: :btree
  add_index "telefono", ["id_telefono"], name: "telefono_pk", unique: true, using: :btree

  create_table "tipo_de_centro", primary_key: "id_tipocentro", force: :cascade do |t|
    t.string "nombre_tipocentro", limit: 32, null: false
  end

  add_index "tipo_de_centro", ["id_tipocentro"], name: "tipo_de_centro_pk", unique: true, using: :btree

  create_table "usuarios", force: :cascade do |t|
    t.string   "nombre"
    t.string   "paterno"
    t.string   "materno"
    t.string   "rut"
    t.string   "digito"
    t.string   "calle"
    t.string   "numero"
    t.string   "departamento"
    t.string   "comuna"
    t.string   "email"
    t.string   "telefono"
    t.string   "contraseña"
    t.string   "prevision"
    t.integer  "sexo"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_foreign_key "agenda", "centro_de_salud", column: "id_centrosalud", primary_key: "id_centrosalud", name: "fk_agenda_centro_ti_centro_d", on_update: :restrict, on_delete: :restrict
  add_foreign_key "agenda", "medico", column: "id_persona", primary_key: "id_persona", name: "fk_agenda_medico_ti_medico", on_update: :restrict, on_delete: :restrict
  add_foreign_key "bloque", "agenda", column: "id_agenda", primary_key: "id_agenda", name: "fk_bloque_agenda_ti_agenda", on_update: :restrict, on_delete: :restrict
  add_foreign_key "centro_de_salud", "comuna", column: "id_comuna", primary_key: "id_comuna", name: "fk_centro_d_centro_es_comuna", on_update: :restrict, on_delete: :restrict
  add_foreign_key "centro_de_salud", "tipo_de_centro", column: "id_tipocentro", primary_key: "id_tipocentro", name: "fk_centro_d_centro_pe_tipo_de_", on_update: :restrict, on_delete: :restrict
  add_foreign_key "cita", "bloque", column: "id_bloque", primary_key: "id_bloque", name: "fk_cita_bloque_ti_bloque", on_update: :restrict, on_delete: :restrict
  add_foreign_key "cita", "estado_cita", column: "id_estadocita", primary_key: "id_estadocita", name: "fk_cita_cita_tien_estado_c", on_update: :restrict, on_delete: :restrict
  add_foreign_key "cita", "paciente", column: "id_persona", primary_key: "id_persona", name: "fk_cita_paciente__paciente", on_update: :restrict, on_delete: :restrict
  add_foreign_key "especialidades_medico", "especialidad", column: "id_especialidad", primary_key: "id_especialidad", name: "fk_especial_espmedico_especial", on_update: :restrict, on_delete: :restrict
  add_foreign_key "especialidades_medico", "medico", column: "id_persona", primary_key: "id_persona", name: "fk_especial_medico_ti_medico", on_update: :restrict, on_delete: :restrict
  add_foreign_key "funcionario", "centro_de_salud", column: "id_centrosalud", primary_key: "id_centrosalud", name: "fk_funciona_func_trab_centro_d", on_update: :restrict, on_delete: :restrict
  add_foreign_key "funcionario", "persona", column: "id_persona", primary_key: "id_persona", name: "fk_funciona_es3_persona", on_update: :restrict, on_delete: :restrict
  add_foreign_key "medico", "persona", column: "id_persona", primary_key: "id_persona", name: "fk_medico_es_persona", on_update: :restrict, on_delete: :restrict
  add_foreign_key "paciente", "comuna", column: "id_comuna", primary_key: "id_comuna", name: "fk_paciente_paciente__comuna", on_update: :restrict, on_delete: :restrict
  add_foreign_key "paciente", "persona", column: "id_persona", primary_key: "id_persona", name: "fk_paciente_es2_persona", on_update: :restrict, on_delete: :restrict
  add_foreign_key "persona", "rol", column: "id_rol", primary_key: "id_rol", name: "fk_persona_persona_t_rol", on_update: :restrict, on_delete: :restrict
  add_foreign_key "telefono", "centro_de_salud", column: "id_centrosalud", primary_key: "id_centrosalud", name: "fk_telefono_centro_ti_centro_d", on_update: :restrict, on_delete: :restrict
  add_foreign_key "telefono", "persona", column: "id_persona", primary_key: "id_persona", name: "fk_telefono_persona_t_persona", on_update: :restrict, on_delete: :restrict
end
