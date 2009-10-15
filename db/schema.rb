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

ActiveRecord::Schema.define(:version => 20091014193845) do

  create_table "ajudas", :force => true do |t|
    t.integer "entidade_id"
    t.integer "ajudavel_id"
    t.string  "ajudavel_type"
    t.text    "conteudo"
  end

  create_table "artefatos", :force => true do |t|
    t.integer  "entidade_id"
    t.integer  "cadastro_id"
    t.string   "objeto_file_name"
    t.string   "objeto_content_type"
    t.integer  "objeto_file_size"
    t.datetime "objeto_updated_at"
    t.text     "ocr"
  end

  create_table "blogs", :force => true do |t|
    t.integer  "entidade_id"
    t.integer  "usuario_id"
    t.integer  "destinatario_id"
    t.string   "menssagem"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "blogs", ["destinatario_id"], :name => "index_blogs_on_destinatario_id"
  add_index "blogs", ["entidade_id"], :name => "index_blogs_on_entidade_id"
  add_index "blogs", ["menssagem"], :name => "index_blogs_on_menssagem"
  add_index "blogs", ["usuario_id"], :name => "index_blogs_on_usuario_id"

  create_table "cadastros", :force => true do |t|
    t.integer  "entidade_id"
    t.integer  "formulario_id"
    t.integer  "usuario_id"
    t.integer  "formulariotipo_id"
    t.integer  "formulariocategoria_id"
    t.integer  "parent_id"
    t.boolean  "status"
    t.boolean  "publicado",              :default => false
    t.text     "filtro"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cadastros", ["entidade_id"], :name => "index_cadastros_on_entidade_id"
  add_index "cadastros", ["formulario_id"], :name => "index_cadastros_on_formulario_id"
  add_index "cadastros", ["formulariocategoria_id"], :name => "index_cadastros_on_formulariocategoria_id"
  add_index "cadastros", ["formulariotipo_id"], :name => "index_cadastros_on_formulariotipo_id"
  add_index "cadastros", ["parent_id"], :name => "index_cadastros_on_parent_id"
  add_index "cadastros", ["status"], :name => "index_cadastros_on_status"
  add_index "cadastros", ["usuario_id"], :name => "index_cadastros_on_usuario_id"

  create_table "categoria_noticias", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comentarios", :force => true do |t|
    t.integer  "entidade_id"
    t.integer  "usuario_id"
    t.integer  "comentavel_id"
    t.string   "comentavel_type"
    t.text     "conteudo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ecm_item_data_horas", :force => true do |t|
    t.integer  "entidade_id"
    t.integer  "formulariocategoria_id"
    t.integer  "formulario_id"
    t.integer  "itensformulario_id"
    t.integer  "cadastro_id"
    t.integer  "campo"
    t.datetime "conteudo"
  end

  add_index "ecm_item_data_horas", ["cadastro_id"], :name => "index_ecm_item_data_horas_on_cadastro_id"
  add_index "ecm_item_data_horas", ["conteudo"], :name => "index_ecm_item_data_horas_on_conteudo"
  add_index "ecm_item_data_horas", ["entidade_id", "formulariocategoria_id", "formulario_id", "itensformulario_id", "cadastro_id", "conteudo"], :name => "index_ecm_data_horas"
  add_index "ecm_item_data_horas", ["entidade_id"], :name => "index_ecm_item_data_horas_on_entidade_id"
  add_index "ecm_item_data_horas", ["formulario_id"], :name => "index_ecm_item_data_horas_on_formulario_id"
  add_index "ecm_item_data_horas", ["formulariocategoria_id"], :name => "index_ecm_item_data_horas_on_formulariocategoria_id"
  add_index "ecm_item_data_horas", ["itensformulario_id"], :name => "index_ecm_item_data_horas_on_itensformulario_id"

  create_table "ecm_item_datas", :force => true do |t|
    t.integer "entidade_id"
    t.integer "formulariocategoria_id"
    t.integer "formulario_id"
    t.integer "itensformulario_id"
    t.integer "cadastro_id"
    t.integer "campo"
    t.date    "conteudo"
  end

  add_index "ecm_item_datas", ["cadastro_id"], :name => "index_ecm_item_datas_on_cadastro_id"
  add_index "ecm_item_datas", ["conteudo"], :name => "index_ecm_item_datas_on_conteudo"
  add_index "ecm_item_datas", ["entidade_id", "formulariocategoria_id", "formulario_id", "itensformulario_id", "cadastro_id", "conteudo"], :name => "index_ecm_datas"
  add_index "ecm_item_datas", ["entidade_id"], :name => "index_ecm_item_datas_on_entidade_id"
  add_index "ecm_item_datas", ["formulario_id"], :name => "index_ecm_item_datas_on_formulario_id"
  add_index "ecm_item_datas", ["formulariocategoria_id"], :name => "index_ecm_item_datas_on_formulariocategoria_id"
  add_index "ecm_item_datas", ["itensformulario_id"], :name => "index_ecm_item_datas_on_itensformulario_id"

  create_table "ecm_item_imagems", :force => true do |t|
    t.integer "entidade_id"
    t.integer "formulariocategoria_id"
    t.integer "formulario_id"
    t.integer "itensformulario_id"
    t.integer "cadastro_id"
    t.integer "campo"
    t.string  "imagem_file_name"
    t.string  "imagem_content_type"
    t.integer "imagem_file_size"
  end

  add_index "ecm_item_imagems", ["cadastro_id"], :name => "index_ecm_item_imagems_on_cadastro_id"
  add_index "ecm_item_imagems", ["entidade_id", "formulariocategoria_id", "formulario_id", "itensformulario_id", "cadastro_id"], :name => "index_ecm_imagem"
  add_index "ecm_item_imagems", ["entidade_id"], :name => "index_ecm_item_imagems_on_entidade_id"
  add_index "ecm_item_imagems", ["formulario_id"], :name => "index_ecm_item_imagems_on_formulario_id"
  add_index "ecm_item_imagems", ["formulariocategoria_id"], :name => "index_ecm_item_imagems_on_formulariocategoria_id"
  add_index "ecm_item_imagems", ["itensformulario_id"], :name => "index_ecm_item_imagems_on_itensformulario_id"

  create_table "ecm_item_numero_decimals", :force => true do |t|
    t.integer "entidade_id"
    t.integer "formulariocategoria_id"
    t.integer "formulario_id"
    t.integer "itensformulario_id"
    t.integer "cadastro_id"
    t.integer "campo"
    t.float   "conteudo"
  end

  add_index "ecm_item_numero_decimals", ["cadastro_id"], :name => "index_ecm_item_numero_decimals_on_cadastro_id"
  add_index "ecm_item_numero_decimals", ["conteudo"], :name => "index_ecm_item_numero_decimals_on_conteudo"
  add_index "ecm_item_numero_decimals", ["entidade_id", "formulariocategoria_id", "formulario_id", "itensformulario_id", "cadastro_id", "conteudo"], :name => "index_ecm_numero_decimals"
  add_index "ecm_item_numero_decimals", ["entidade_id"], :name => "index_ecm_item_numero_decimals_on_entidade_id"
  add_index "ecm_item_numero_decimals", ["formulario_id"], :name => "index_ecm_item_numero_decimals_on_formulario_id"
  add_index "ecm_item_numero_decimals", ["formulariocategoria_id"], :name => "index_ecm_item_numero_decimals_on_formulariocategoria_id"
  add_index "ecm_item_numero_decimals", ["itensformulario_id"], :name => "index_ecm_item_numero_decimals_on_itensformulario_id"

  create_table "ecm_item_numero_inteiros", :force => true do |t|
    t.integer "entidade_id"
    t.integer "formulariocategoria_id"
    t.integer "formulario_id"
    t.integer "itensformulario_id"
    t.integer "cadastro_id"
    t.integer "campo"
    t.integer "conteudo"
  end

  add_index "ecm_item_numero_inteiros", ["cadastro_id"], :name => "index_ecm_item_numero_inteiros_on_cadastro_id"
  add_index "ecm_item_numero_inteiros", ["conteudo"], :name => "index_ecm_item_numero_inteiros_on_conteudo"
  add_index "ecm_item_numero_inteiros", ["entidade_id", "formulariocategoria_id", "formulario_id", "itensformulario_id", "cadastro_id", "conteudo"], :name => "index_ecm_numero_inteiros"
  add_index "ecm_item_numero_inteiros", ["entidade_id"], :name => "index_ecm_item_numero_inteiros_on_entidade_id"
  add_index "ecm_item_numero_inteiros", ["formulario_id"], :name => "index_ecm_item_numero_inteiros_on_formulario_id"
  add_index "ecm_item_numero_inteiros", ["formulariocategoria_id"], :name => "index_ecm_item_numero_inteiros_on_formulariocategoria_id"
  add_index "ecm_item_numero_inteiros", ["itensformulario_id"], :name => "index_ecm_item_numero_inteiros_on_itensformulario_id"

  create_table "ecm_item_referencias", :force => true do |t|
    t.integer "entidade_id"
    t.integer "formulariocategoria_id"
    t.integer "formulario_id"
    t.integer "itensformulario_id"
    t.integer "cadastro_id"
    t.integer "campo"
    t.integer "referencia_id"
  end

  add_index "ecm_item_referencias", ["cadastro_id"], :name => "index_ecm_item_referencias_on_cadastro_id"
  add_index "ecm_item_referencias", ["entidade_id", "formulariocategoria_id", "itensformulario_id", "formulario_id", "cadastro_id", "referencia_id"], :name => "index_ecm_referencias"
  add_index "ecm_item_referencias", ["entidade_id"], :name => "index_ecm_item_referencias_on_entidade_id"
  add_index "ecm_item_referencias", ["formulario_id"], :name => "index_ecm_item_referencias_on_formulario_id"
  add_index "ecm_item_referencias", ["formulariocategoria_id"], :name => "index_ecm_item_referencias_on_formulariocategoria_id"
  add_index "ecm_item_referencias", ["itensformulario_id"], :name => "index_ecm_item_referencias_on_itensformulario_id"
  add_index "ecm_item_referencias", ["referencia_id"], :name => "index_ecm_item_referencias_on_referencia_id"

  create_table "ecm_item_texto_longos", :force => true do |t|
    t.integer "entidade_id"
    t.integer "formulariocategoria_id"
    t.integer "formulario_id"
    t.integer "itensformulario_id"
    t.integer "cadastro_id"
    t.integer "campo"
    t.text    "conteudo"
  end

  add_index "ecm_item_texto_longos", ["cadastro_id"], :name => "index_ecm_item_texto_longos_on_cadastro_id"
  add_index "ecm_item_texto_longos", ["entidade_id", "formulariocategoria_id", "formulario_id", "itensformulario_id", "cadastro_id"], :name => "index_ecm_texto_longos"
  add_index "ecm_item_texto_longos", ["entidade_id"], :name => "index_ecm_item_texto_longos_on_entidade_id"
  add_index "ecm_item_texto_longos", ["formulario_id"], :name => "index_ecm_item_texto_longos_on_formulario_id"
  add_index "ecm_item_texto_longos", ["formulariocategoria_id"], :name => "index_ecm_item_texto_longos_on_formulariocategoria_id"
  add_index "ecm_item_texto_longos", ["itensformulario_id"], :name => "index_ecm_item_texto_longos_on_itensformulario_id"

  create_table "ecm_item_textos", :force => true do |t|
    t.integer "entidade_id"
    t.integer "formulariocategoria_id"
    t.integer "formulario_id"
    t.integer "itensformulario_id"
    t.integer "cadastro_id"
    t.integer "campo"
    t.string  "conteudo"
  end

  add_index "ecm_item_textos", ["cadastro_id"], :name => "index_ecm_item_textos_on_cadastro_id"
  add_index "ecm_item_textos", ["conteudo"], :name => "index_ecm_item_textos_on_conteudo"
  add_index "ecm_item_textos", ["entidade_id", "formulariocategoria_id", "itensformulario_id", "formulario_id", "cadastro_id", "conteudo"], :name => "index_ecm_texto"
  add_index "ecm_item_textos", ["entidade_id"], :name => "index_ecm_item_textos_on_entidade_id"
  add_index "ecm_item_textos", ["formulario_id"], :name => "index_ecm_item_textos_on_formulario_id"
  add_index "ecm_item_textos", ["formulariocategoria_id"], :name => "index_ecm_item_textos_on_formulariocategoria_id"
  add_index "ecm_item_textos", ["itensformulario_id"], :name => "index_ecm_item_textos_on_itensformulario_id"

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
    t.string   "tema"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entidades", ["endereco"], :name => "index_entidades_on_endereco"
  add_index "entidades", ["nome"], :name => "index_entidades_on_nome"
  add_index "entidades", ["nome_responsavel"], :name => "index_entidades_on_nome_responsavel"
  add_index "entidades", ["razao_social"], :name => "index_entidades_on_razao_social"
  add_index "entidades", ["telefone_responsavel"], :name => "index_entidades_on_telefone_responsavel"

  create_table "formulariocategorias", :force => true do |t|
    t.integer "entidade_id"
    t.string  "nome"
    t.string  "descricao"
  end

  create_table "formularios", :force => true do |t|
    t.integer  "formulariocategoria_id"
    t.integer  "formulariotipo_id"
    t.integer  "entidade_id"
    t.integer  "principal_id"
    t.string   "titulo"
    t.string   "descricao"
    t.boolean  "status",                 :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "formularios", ["entidade_id"], :name => "index_formularios_on_entidade_id"
  add_index "formularios", ["formulariocategoria_id"], :name => "index_formularios_on_formulariocategoria_id"
  add_index "formularios", ["formulariotipo_id"], :name => "index_formularios_on_formulariotipo_id"
  add_index "formularios", ["status"], :name => "index_formularios_on_status"
  add_index "formularios", ["titulo"], :name => "index_formularios_on_titulo"

  create_table "formulariotipos", :force => true do |t|
    t.string  "tipo"
    t.boolean "status"
  end

  create_table "grupoformularios", :force => true do |t|
    t.integer "grupo_id"
    t.integer "formulario_id"
    t.integer "permissao"
  end

  add_index "grupoformularios", ["formulario_id"], :name => "index_grupoformularios_on_formulario_id"
  add_index "grupoformularios", ["grupo_id"], :name => "index_grupoformularios_on_grupo_id"
  add_index "grupoformularios", ["permissao"], :name => "index_grupoformularios_on_permissao"

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

  create_table "itensformularios", :force => true do |t|
    t.integer "entidade_id"
    t.integer "formulario_id"
    t.integer "itenstipo_id"
    t.string  "rotulo"
    t.integer "posicao"
    t.string  "componente"
    t.string  "tipo"
    t.text    "opcoes"
  end

  create_table "itenstipos", :force => true do |t|
    t.string  "nome"
    t.string  "tipo"
    t.string  "componente"
    t.boolean "status"
  end

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

  create_table "noticias", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "paginaentidades", :force => true do |t|
    t.integer  "entidade_id"
    t.integer  "usuario_id"
    t.text     "pagina"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "usuario_blogs", :force => true do |t|
    t.integer "entidade_id"
    t.integer "usuario_id"
    t.integer "seguido_id"
  end

  add_index "usuario_blogs", ["entidade_id"], :name => "index_usuario_blogs_on_entidade_id"
  add_index "usuario_blogs", ["seguido_id"], :name => "index_usuario_blogs_on_seguido_id"
  add_index "usuario_blogs", ["usuario_id"], :name => "index_usuario_blogs_on_usuario_id"

  create_table "usuarios", :force => true do |t|
    t.integer  "entidade_id"
    t.string   "nome"
    t.string   "login"
    t.string   "email"
    t.string   "senha_encriptada"
    t.string   "chave_criptografia"
    t.boolean  "status",              :default => true
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "usuarios", ["entidade_id"], :name => "index_usuarios_on_entidade_id"
  add_index "usuarios", ["login", "senha_encriptada"], :name => "index_login_senha"
  add_index "usuarios", ["login"], :name => "index_usuarios_on_login"
  add_index "usuarios", ["nome"], :name => "index_usuarios_on_nome"
  add_index "usuarios", ["senha_encriptada"], :name => "index_usuarios_on_senha_encriptada"
  add_index "usuarios", ["status"], :name => "index_usuarios_on_status"

  create_table "wikicategorias", :force => true do |t|
    t.integer "entidade_id"
    t.string  "nome"
    t.integer "parent_id"
  end

  create_table "wikihistoriapages", :force => true do |t|
    t.integer  "wikipage_id"
    t.integer  "usuario_id"
    t.text     "conteudo_antigo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wikipages", :force => true do |t|
    t.integer  "entidade_id"
    t.integer  "wikicategoria_id"
    t.string   "titulo"
    t.text     "conteudo"
    t.boolean  "protegido",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
