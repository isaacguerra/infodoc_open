class Core::UsuariosController < ApplicationController
  def index
    @entidade = Entidade.find params[:entidade_id]
  end

  def show
    @entidade = Entidade.find params[:entidade_id]
    @usuario = Usuario.find params[:id]
  end

  def new
    @entidade = Entidade.find params[:entidade_id]
    @usuario = @entidade.usuarios.new
  end

  def create
    @usuario = Usuario.new(params[:usuario])
    @usuario.entidade_id=params[:entidade_id]
    @usuario.status = true
	  if @usuario.save
	    flash[:notice] = "Usuario Criado com Sucesso!"
      redirect_to :controller=>"usuarios",:action=>"show",:id=>@usuario.id
    else
       render :action => "new"
    end
  end

  def edit
    @entidade = Entidade.find(params[:entidade_id])
    @usuario = Usuario.find(params[:id])
  end

  def update
    @usuario = Usuario.find(params[:id])
    if @usuario.update_attributes(params[:usuario])
      flash[:notice] = "Usuario Atualizado com Sucesso!"
      redirect_to :controller=>"usuarios",:action=>"show",:id=>@usuario.id
    else
       render :action=> :edit, :id=>@usuario
    end
  end

  def mudar_status
    @usuario = Usuario.find(params[:id])
    if @usuario.status
      @usuario.status = false
    else
      @usuario.status = true
    end
    @usuario.save
    flash[:notice] = "Status Alterad com Sucesso!"
    render :action=> :show, :id=>@usuario
  end
end

