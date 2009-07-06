class Core::InstallController < ApplicationController
  skip_before_filter :autenticado
  skip_before_filter :autorizado
  layout "home"

  def index
    entidade = Entidade.create(:nome=>"Infomanager", :razao_social=>"Infomanager Ltda", :cpf_cnpj=>"08505672/0001-60", :cidade=>"Macapá", :endereco=>"Rua Iraci Nunes Nadler, nº 346", :bairro=>"Santa Nines", :cep=>"68901-380", :telefone=>"3242-5877", :email=>"comercial@infomanagerbrasil.com.br", :nome_responsavel=>"Isaac de Almeida Gerra", :telefone_responsavel=>"8113-8057", :email_responsavel=>"isaac@infomanagerbrasil.com.br", :status=>true)
    madmg = Modulo.create(:nome=>"Administração Geral", :descricao=>"Administração Geral")
    madm = Modulo.create(:nome=>"Administração", :descricao=>"Administração")

    Moduloentidade.create(:entidade_id=>entidade.id, :modulo_id=>madmg.id)
    Moduloentidade.create(:entidade_id=>entidade.id, :modulo_id=>madm.id)

    gerenciaentidades = Sistema.create(:nome=>"Gerencia de Entidades", :descricao=>"Gerencia de Entidades", :rota=>"/core/entidades", :controle=>"Core::EntidadesController", :menu=>true, :status=>true, :modulo_id=>madmg.id)
    gerenciausuarios = Sistema.create(:nome=>"Gerencia de Usuarios", :descricao=>"Gerencia de Usuarios", :rota=>"/core/entidades", :controle=>"Core::UsuariosController", :menu=>false, :status=>true, :modulo_id=>madmg.id)
    gerenciagrupos = Sistema.create(:nome=>"Gerencia de Grupos", :descricao=>"Gerencia de Grupos", :rota=>"/core/entidades", :controle=>"Core::GruposController", :menu=>false, :status=>true, :modulo_id=>madmg.id)
    liberacaodemodulos = Sistema.create(:nome=>"Liberação de Modulos a Entidades", :descricao=>"Liberação de Modulos a Entidades", :rota=>"/core/entidades", :controle=>"Core::ModuloentidadesController", :menu=>false, :status=>true, :modulo_id=>madmg.id)
    gerenciademodulos = Sistema.create(:nome=>"Gerencia de Modulos", :descricao=>"Gerencia de Modulos", :rota=>"/core/modulos", :controle=>"Core::ModulosController", :menu=>true, :status=>true, :modulo_id=>madmg.id)
    gerenciadesistemas = Sistema.create(:nome=>"Gerencia de Sistemas", :descricao=>"Gerencia de Sistemas", :rota=>"/core/modulos", :controle=>"Core::SistemasController", :menu=>false, :status=>true, :modulo_id=>madmg.id)

    administracaodegrupos = Sistema.create(:nome=>"Administração de Grupos", :descricao=>"Administração de Grupos", :rota=>"/core/admingrupos", :controle=>"Core::AdmingruposController", :menu=>true, :status=>true, :modulo_id=>madm.id)
    administracaodeusuarios = Sistema.create(:nome=>"Administração de Usuarios", :descricao=>"Administração de Usuarios", :rota=>"/core/adminusuarios", :controle=>"Core::AdminusuariosController", :menu=>true, :status=>true, :modulo_id=>madm.id)
    administracaomudarsenha = Sistema.create(:nome=>"Administração de Mudança de Senha", :descricao=>"Administração de Mudança de Senha", :rota=>"/core/adminusuarios", :controle=>"Core::AdminmudarsenhasController", :menu=>false, :status=>true, :modulo_id=>madm.id)
    vincularusuariogrupo = Sistema.create(:nome=>"Vinculação de Usuarios aos Grupos", :descricao=>"Vinculação de Usuarios aos Grupos", :rota=>"/core/admingrupos", :controle=>"Core::GrupousuariosController", :menu=>false, :status=>true, :modulo_id=>madm.id)
    vincularsistemagrupo = Sistema.create(:nome=>"Vinculação de Sistemas aos Grupos", :descricao=>"Vinculação de sistema aos Grupos", :rota=>"/core/admingrupos", :controle=>"Core::GruposistemasController", :menu=>false, :status=>true, :modulo_id=>madm.id)
    perfil = Sistema.create(:nome=>"Perfil do Usuario", :descricao=>"Perfil do Usuario", :rota=>"/core/perfil", :controle=>"Core::PerfilController", :menu=>true, :status=>true, :modulo_id=>madm.id)

    grupoadministrador = Grupo.create(:entidade_id=>entidade.id, :nome=>"Administradores", :descricao=>"Administradores")

    Sistema.all.each {|s| Gruposistema.create(:grupo_id=>grupoadministrador.id, :sistema_id=>s.id, :permissao=>3)}
    u = Usuario.new
    @senha = u.random_alphanumeric(6)
    usuario = Usuario.create(:entidade_id=>entidade.id, :nome=>"Administrador", :login=>"admin", :email=>"contato@infomanagerbrasil.com.br", :senha=>@senha, :senha_confirmation=>@senha, :status=>true)

    Grupousuario.create(:usuario_id=>usuario.id, :grupo_id=>grupoadministrador.id)
  end
end

