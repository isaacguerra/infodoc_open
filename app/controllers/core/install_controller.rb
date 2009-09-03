class Core::InstallController < ApplicationController
  skip_before_filter :autenticado
  skip_before_filter :autorizado
  layout "home"

  def index
    @log  = ""
    entidade = Entidade.create(:nome=>"Infomanager", :razao_social=>"Infomanager Ltda", :cpf_cnpj=>"08505672000160", :cidade=>"Macapá", :endereco=>"Rua Iraci Nunes Nadler, nº 346", :bairro=>"Santa Nines", :cep=>"68901-380", :telefone=>"3242-5877", :email=>"comercial@infomanagerbrasil.com.br", :nome_responsavel=>"Isaac de Almeida Gerra", :telefone_responsavel=>"8113-8057", :email_responsavel=>"isaac@infomanagerbrasil.com.br", :status=>true)
    @log << "#ID da Entidade - #{entidade.id}\n"
    madmg = Modulo.create(:nome=>"Administração Geral", :descricao=>"Administração Geral")
    @log << "#ID da modulos Administracao Geral - #{madmg.id}\n"
    madm = Modulo.create(:nome=>"Administração", :descricao=>"Administração")
    @log << "#ID da modulos Administracao - #{madm.id}\n"
    mecm = Modulo.create(:nome=>"Gerencia ECM", :descricao=>"Gerencia ECM")
    @log << "#ID da modulos ECM - #{mecm.id}\n"
    mgc = Modulo.create(:nome=>"Gerencia de Conteúdo", :descricao=>"Gerencia de Conteúdo")
    @log << "#ID da modulos Gerencia de Conteúdo - #{mgc.id}\n"
    mwiki = Modulo.create(:nome=>"Wiki", :descricao=>"Wiki de Conteúdo")
    @log << "#ID da modulos Wiki - #{mwiki.id}\n"

    vmadmg = Moduloentidade.create(:entidade_id=>entidade.id, :modulo_id=>madmg.id)
    vmadm = Moduloentidade.create(:entidade_id=>entidade.id, :modulo_id=>madm.id)
    vecm = Moduloentidade.create(:entidade_id=>entidade.id, :modulo_id=>mecm.id)
    vgc = Moduloentidade.create(:entidade_id=>entidade.id, :modulo_id=>mgc.id)
    vwiki = Moduloentidade.create(:entidade_id=>entidade.id, :modulo_id=>mwiki.id)
    @log << "#ID da vinculação do modulo a entidade - #{vmadmg.id}\n"
    @log << "#ID da vinculação do modulo a entidade - #{vmadm.id}\n"
    @log << "#ID da vinculação do modulo a entidade - #{vecm.id}\n"
    @log << "#ID da vinculação do modulo a entidade - #{vgc.id}\n"
    @log << "#ID da vinculação do modulo a entidade - #{vwiki.id}\n"

    gerenciaentidades = Sistema.create(:nome=>"Gerencia de Entidades", :descricao=>"Gerencia de Entidades", :rota=>"/core/entidades", :controle=>"Core::EntidadesController", :menu=>true, :status=>true, :modulo_id=>madmg.id)
    @log << "#ID do sistema  de Gerencia da Entidades - #{gerenciaentidades.id}\n"
    gerenciausuarios = Sistema.create(:nome=>"Gerencia de Usuarios", :descricao=>"Gerencia de Usuarios", :rota=>"/core/entidades", :controle=>"Core::UsuariosController", :menu=>false, :status=>true, :modulo_id=>madmg.id)
    @log << "#ID do sistema  de Gerencia de Usuarios - #{gerenciausuarios.id}\n"
    gerenciagrupos = Sistema.create(:nome=>"Gerencia de Grupos", :descricao=>"Gerencia de Grupos", :rota=>"/core/entidades", :controle=>"Core::GruposController", :menu=>false, :status=>true, :modulo_id=>madmg.id)
    @log << "#ID do sistema  de Gerencia de Grupos - #{gerenciagrupos.id}\n"
    liberacaodemodulos = Sistema.create(:nome=>"Liberação de Modulos a Entidades", :descricao=>"Liberação de Modulos a Entidades", :rota=>"/core/entidades", :controle=>"Core::ModuloentidadesController", :menu=>false, :status=>true, :modulo_id=>madmg.id)
    @log << "#ID do sistema  de Gerencia de Liberacao de modlos - #{liberacaodemodulos.id}\n"
    gerenciademodulos = Sistema.create(:nome=>"Gerencia de Modulos", :descricao=>"Gerencia de Modulos", :rota=>"/core/modulos", :controle=>"Core::ModulosController", :menu=>true, :status=>true, :modulo_id=>madmg.id)
    @log << "#ID do sistema  de Gerencia Modulos - #{gerenciademodulos.id}\n"
    gerenciadesistemas = Sistema.create(:nome=>"Gerencia de Sistemas", :descricao=>"Gerencia de Sistemas", :rota=>"/core/modulos", :controle=>"Core::SistemasController", :menu=>false, :status=>true, :modulo_id=>madmg.id)
    @log << "#ID do sistema  de Gerencia de Sistemas - #{gerenciadesistemas.id}\n"

    administracaodegrupos = Sistema.create(:nome=>"Administração de Grupos", :descricao=>"Administração de Grupos", :rota=>"/core/admingrupos", :controle=>"Core::AdmingruposController", :menu=>true, :status=>true, :modulo_id=>madm.id)
    @log << "#ID do sistema  de Administracao de grupos - #{administracaodegrupos.id}\n"
    administracaodeusuarios = Sistema.create(:nome=>"Administração de Usuarios", :descricao=>"Administração de Usuarios", :rota=>"/core/adminusuarios", :controle=>"Core::AdminusuariosController", :menu=>true, :status=>true, :modulo_id=>madm.id)
    @log << "#ID do sistema  de Administracao de usuarios - #{administracaodeusuarios.id}\n"
    administracaomudarsenha = Sistema.create(:nome=>"Administração de Mudança de Senha", :descricao=>"Administração de Mudança de Senha", :rota=>"/core/adminusuarios", :controle=>"Core::AdminmudarsenhasController", :menu=>false, :status=>true, :modulo_id=>madm.id)
    @log << "#ID do sistema  de Administracao de senhas - #{administracaomudarsenha.id}\n"
    vincularusuariogrupo = Sistema.create(:nome=>"Vinculação de Usuarios aos Grupos", :descricao=>"Vinculação de Usuarios aos Grupos", :rota=>"/core/admingrupos", :controle=>"Core::GrupousuariosController", :menu=>false, :status=>true, :modulo_id=>madm.id)
    @log << "#ID do sistema de Vinculacao Usuario a grupos - #{vincularusuariogrupo.id}\n"
    vincularsistemagrupo = Sistema.create(:nome=>"Vinculação de Sistemas aos Grupos", :descricao=>"Vinculação de sistema aos Grupos", :rota=>"/core/admingrupos", :controle=>"Core::GruposistemasController", :menu=>false, :status=>true, :modulo_id=>madm.id)
    @log << "#ID do sistema de Vinculacao Sistema a grupos - #{vincularsistemagrupo.id}\n"
    perfil = Sistema.create(:nome=>"Perfil do Usuario", :descricao=>"Perfil do Usuario", :rota=>"/core/perfil", :controle=>"Core::PerfilController", :menu=>true, :status=>true, :modulo_id=>madm.id)
    @log << "#ID do sistema de Perfil - #{perfil.id}\n"

    cadastro = Sistema.create(:nome=>"Cadastros", :descricao=>"Cadastro", :rota=>"/ecm/cadastros", :controle=>"Ecm::CadastrosController", :menu=>false, :status=>true, :modulo_id=>mgc.id)
    @log << "#ID do sistema  de Gerencia de Cadastro - #{cadastro.id}\n"

    scwiki = Sistema.create(:nome=>"InfoWiki", :descricao=>"infocategoriawiki", :rota=>"/wiki/wikicategorias", :controle=>"Wiki::WikicategoriasController", :menu=>true, :status=>true, :modulo_id=>mwiki.id)
    swiki = Sistema.create(:nome=>"InfoWiki", :descricao=>"infowiki", :rota=>"/wiki/wikipages", :controle=>"Wiki::WikipagesController", :menu=>false, :status=>true, :modulo_id=>mwiki.id)
    shwiki = Sistema.create(:nome=>"InfoHistoriaWiki", :descricao=>"infohistoriawiki", :rota=>"/wiki/wiki", :controle=>"Wiki::WikihistoriapagesController", :menu=>false, :status=>true, :modulo_id=>mwiki.id)

    #ecm tipos de itens
    Formulariotipo.create(:tipo=>"Pasta", :status=>true)
    Formulariotipo.create(:tipo=>"Arquivo", :status=>true)
    Formulariotipo.create(:tipo=>"Migração", :status=>false)
    Formulariotipo.create(:tipo=>"Itentegração com SGBD", :status=>false)
    Formulariotipo.create(:tipo=>"Itentegração com Web Service", :status=>false)

    #ecm tipos de itens
    Itenstipo.create(:nome=>"Texto", :tipo=>"texto", :status=>true, :componente=>"texto")
    Itenstipo.create(:nome=>"Text Longo", :tipo=>"texto_longo", :status=>true, :componente=>"texto_longo")
    Itenstipo.create(:nome=>"Numero", :tipo=>"numero_inteiro", :status=>true, :componente=>"numero_inteiro")
    Itenstipo.create(:nome=>"Valor Monetario", :tipo=>"valor_monetario", :status=>true, :componente=>"valor_monetario")
    Itenstipo.create(:nome=>"Data", :tipo=>"data", :status=>true, :componente=>"data")
    Itenstipo.create(:nome=>"Data e Hora", :tipo=>"data_hora", :status=>true, :componente=>"data_hora")
    Itenstipo.create(:nome=>"Lista", :tipo=>"texto", :status=>true, :componente=>"lista")
    Itenstipo.create(:nome=>"Imagem", :tipo=>"imagem", :status=>true, :componente=>"imagem")
    Itenstipo.create(:nome=>"Referencia", :tipo=>"referencia", :status=>true, :componente=>"referencia")
    Itenstipo.create(:nome=>"Soma em Referencia", :tipo=>"referencia", :status=>true, :componente=>"soma_referencia")
    Itenstipo.create(:nome=>"Identificador Unico", :tipo=>"texto", :status=>true, :componente=>"identificador_unico")
    Itenstipo.create(:nome=>"CPF/CNPJ", :tipo=>"texto", :status=>true, :componente=>"cpf_cnpj")
    Itenstipo.create(:nome=>"Auto Numeração", :tipo=>"texto", :status=>true, :componente=>"auto_numeracao")


    ecmcategoria = Sistema.create(:nome=>"Categoria de Formularios", :descricao=>"Categoria de Formularios", :rota=>"/ecm/categorias", :controle=>"Ecm::CategoriasController", :menu=>true, :status=>true, :modulo_id=>mecm.id)
    @log << "#ID do Categoria de Formularios - #{ecmcategoria.id}\n"
    ecmformulario = Sistema.create(:nome=>"Formularios", :descricao=>"Formularios", :rota=>"/ecm/categorias", :controle=>"Ecm::FormulariosController", :menu=>false, :status=>true, :modulo_id=>mecm.id)
    @log << "#ID do Formularios - #{ecmformulario.id}\n"
    ecmitensformulario = Sistema.create(:nome=>"Itens do Formularios", :descricao=>"Itens do Formularios", :rota=>"/ecm/categorias", :controle=>"Ecm::ItensFormulariosController", :menu=>false, :status=>true, :modulo_id=>mecm.id)
    @log << "#ID do Itens Formularios - #{ecmitensformulario.id}\n"
    ecmpermissaoformulario = Sistema.create(:nome=>"Permissoes do Formularios", :descricao=>"Permissoes do Formularios", :rota=>"/ecm/categorias", :controle=>"Ecm::PermissaoFormulariosController", :menu=>false, :status=>true, :modulo_id=>mecm.id)
    @log << "#ID do Itens Formularios - #{ecmpermissaoformulario.id}\n"
    ecmprincipalformulario = Sistema.create(:nome=>"Iten Principal Formularios", :descricao=>"Iten Principal Formularios", :rota=>"/ecm/categorias", :controle=>"Ecm::PrincipalFormulariosController", :menu=>false, :status=>true, :modulo_id=>mecm.id)
    @log << "#ID do Itens Formularios - #{ecmprincipalformulario.id}\n"


    grupoadministrador = Grupo.create(:entidade_id=>entidade.id, :nome=>"Administradores", :descricao=>"Administradores")
    @log << "ID do grupo - #{grupoadministrador.id}\n"

    Sistema.all.each do |s|
       vsg  = Gruposistema.create(:grupo_id=>grupoadministrador.id, :sistema_id=>s.id, :permissao=>3)
       @log << "ID da vinculacao do sistema #{vsg.sistema.nome} - #{vsg.id}\n"
     end
    u = Usuario.new
    @senha = u.random_alphanumeric(6)
    usuario = Usuario.create(:entidade_id=>entidade.id, :nome=>"Administrador", :login=>"admin", :email=>"contato@infomanagerbrasil.com.br", :senha=>@senha, :senha_confirmation=>@senha, :status=>true)
    @log << "ID do Usuario #{usuario.nome}\n"

    vug = Grupousuario.create(:usuario_id=>usuario.id, :grupo_id=>grupoadministrador.id)
    @log << "ID da vinculacao do usuario ao grupo #{vug.id}\n"
  end
end

