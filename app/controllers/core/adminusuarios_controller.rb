class Core::AdminusuariosController < ApplicationController
  def index
    @usuarios = Usuario.find(:all, {:conditions=>["entidade_id = ? ", @sessao_usuario.entidade_id]})
  end

  def show
    @usuario = Usuario.find params[:id]
  end

  def new
    @usuario = Usuario.new
  end

  def create
    @usuario = Usuario.new(params[:usuario])
    @usuario.status = true
	  if @usuario.save
	    flash[:notice] = "Usuario Criado com Sucesso!"
      redirect_to :action=>"show",:id=>@usuario.id
    else
       render :action => "new"
    end
  end

  def edit
    @usuario = Usuario.find(params[:id])
  end

  def update
    @usuario = Usuario.find(params[:id])
    if @usuario.update_attributes(params[:usuario])
      flash[:notice] = "Usuario Atualizado com Sucesso!"
      redirect_to :action=>"show",:id=>@usuario.id
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
    render :action=> :show, :id=>@usuario
  end
end

