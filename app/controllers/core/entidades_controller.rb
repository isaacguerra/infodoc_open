class Core::EntidadesController < ApplicationController
  def index
    @entidades = Entidade.find :all
  end

  def show
    @entidade = Entidade.find params[:id]
  end

  def new
    @entidade = Entidade.new
  end

  def show_create
    @entidade = Entidade.find params[:id]
    modulo = Modulo.find(:first, :conditions=>{:nome=>"Administração"})
    vmadm = Moduloentidade.create(:entidade_id=>@entidade.id, :modulo_id=>modulo.id)
    grupoadministrador = Grupo.create(:entidade_id=>@entidade.id, :nome=>"Administradores", :descricao=>"Administradores")
    modulo.sistemas.each do |s|
      Gruposistema.create(:grupo_id=>grupoadministrador.id, :sistema_id=>s.id, :permissao=>3)
    end
    u = Usuario.new
    @senha = u.random_alphanumeric(6)
    @usuario = Usuario.create(:entidade_id=>@entidade.id, :nome=>@entidade.nome, :login=>@entidade.cpf_cnpj, :email=>@entidade.email_responsavel, :senha=>@senha, :status=>true)
    Grupousuario.create(:usuario_id=>@usuario.id, :grupo_id=>grupoadministrador.id)
  end

  def create
    @entidade = Entidade.new(params[:entidade])
    @entidade.status = true
    if @entidade.save
      flash[:notice] = "Entidade Criado com Sucesso!"
      redirect_to :action=>"show_create", :id=>@entidade.id
    else
      render :action => "new"
    end
  end

  def edit
    @entidade = Entidade.find(params[:id])
  end

  def update
    @entidade = Entidade.find(params[:id])
    if @entidade.update_attributes(params[:entidade])
      flash[:notice] = "Entidade Atualizada com Sucesso!"
      redirect_to core_entidade_path(@entidade)
    else
       render :action=>:edit, :id=>@entidade
    end
  end

  def mudar_status
    @entidade = Entidade.find(params[:id])
    if @entidade.status
      @entidade.status = false
    else
      @entidade.status = true
    end
    @entidade.save
    render :action=> :show, :id=>@entidade
  end
end

