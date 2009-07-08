# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090708125107) do

  create_table "entidades", :force => true do |t|
    t.string   "nome"
    t.string   "razao_social"
    t.string   "cpf_cnpj",             :limit => 18
    t.string   "cidade"
    t.string   "endereco"
    t.string   "bairro"
    t.string   "cep",                  :limit => 10
    t.string   "telefone"
    t.string   "email"
    t.string   "nome_responsavel"
    t.string   "telefone_responsavel"
    t.string   "email_responsavel"
    t.boolean  "status",                             :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entidades", ["endereco"], :name => "index_entidades_on_endereco"
  add_index "entidades", ["nome"], :name => "index_entidades_on_nome"
  add_index "entidades", ["nome_responsavel"], :name => "index_entidades_on_nome_responsavel"
  add_index "entidades", ["razao_social"], :name => "index_entidades_on_razao_social"
  add_index "entidades", ["telefone_responsavel"], :name => "index_entidades_on_telefone_responsavel"

  create_table "grupos", :force => true do |t|
    t.integer  "entidade_id"
    t.string   "nome"
    t.string   "descricao"
    t.boolean  "status",      :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "grupos", ["entidade_id"], :name => "index_grupos_on_entidade_id"
  add_index "grupos", ["nome"], :name => "index_grupos_on_nome"
  add_index "grupos", ["status"], :name => "index_grupos_on_status"

  create_table "gruposistemas", :force => true do |t|
    t.integer "grupo_id"
    t.integer "sistema_id"
    t.integer "permissao"
  end

  add_index "gruposistemas", ["grupo_id"], :name => "index_gruposistemas_on_grupo_id"
  add_index "gruposistemas", ["permissao"], :name => "index_gruposistemas_on_permissao"
  add_index "gruposistemas", ["sistema_id"], :name => "index_gruposistemas_on_sistema_id"

  create_table "grupousuarios", :force => true do |t|
    t.integer "grupo_id"
    t.integer "usuario_id"
  end

  add_index "grupousuarios", ["grupo_id"], :name => "index_grupousuarios_on_grupo_id"
  add_index "grupousuarios", ["usuario_id"], :name => "index_grupousuarios_on_usuario_id"

  create_table "moduloentidades", :force => true do |t|
    t.integer "modulo_id"
    t.integer "entidade_id"
  end

  add_index "moduloentidades", ["entidade_id"], :name => "index_moduloentidades_on_entidade_id"
  add_index "moduloentidades", ["modulo_id"], :name => "index_moduloentidades_on_modulo_id"

  create_table "modulos", :force => true do |t|
    t.string   "nome"
    t.string   "descricao"
    t.boolean  "status",     :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "modulos", ["nome"], :name => "index_modulos_on_nome"

  create_table "sessaos", :force => true do |t|
    t.integer  "usuario_id"
    t.integer  "entidade_id"
    t.string   "nome_usuario"
    t.integer  "num_login"
    t.datetime "ultima_data_acesso"
    t.datetime "corrente_data_login"
    t.datetime "ultima_data_login"
    t.string   "corrente_login_ip"
    t.string   "ultimo_login_ip"
    t.text     "opcoes"
    t.boolean  "status",              :default => true
  end

  add_index "sessaos", ["entidade_id"], :name => "index_sessaos_on_entidade_id"
  add_index "sessaos", ["usuario_id"], :name => "index_sessaos_on_usuario_id"

  create_table "sistemas", :force => true do |t|
    t.integer  "modulo_id"
    t.string   "nome"
    t.string   "descricao"
    t.string   "rota"
    t.string   "controle"
    t.boolean  "menu",       :default => true
    t.boolean  "status",     :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sistemas", ["controle"], :name => "index_sistemas_on_controle"
  add_index "sistemas", ["menu"], :name => "index_sistemas_on_menu"
  add_index "sistemas", ["nome"], :name => "index_sistemas_on_nome"
  add_index "sistemas", ["rota"], :name => "index_sistemas_on_rota"
  add_index "sistemas", ["status"], :name => "index_sistemas_on_status"

  create_table "usuarios", :force => true do |t|
    t.integer  "entidade_id"
    t.string   "nome"
    t.string   "login"
    t.string   "email"
    t.string   "senha_encriptada"
    t.string   "chave_criptografia"
    t.boolean  "status",             :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "usuarios", ["entidade_id"], :name => "index_usuarios_on_entidade_id"
  add_index "usuarios", ["login", "senha_encriptada"], :name => "index_login_senha"
  add_index "usuarios", ["login"], :name => "index_usuarios_on_login"
  add_index "usuarios", ["nome"], :name => "index_usuarios_on_nome"
  add_index "usuarios", ["senha_encriptada"], :name => "index_usuarios_on_senha_encriptada"
  add_index "usuarios", ["status"], :name => "index_usuarios_on_status"

end
