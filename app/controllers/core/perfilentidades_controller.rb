class Core::PerfilentidadesController < ApplicationController
  def index
  end

  def edit
  end

  def update
    @sessao_usuario.entidade.tema = params[:entidade][:tema]
    @sessao_usuario.entidade.logo = params[:entidade][:logo] if params[:entidade][:logo]
    @sessao_usuario.entidade.save
    flash[:notice] = "Perfil Alterado com Sucesso!"
    redirect_to :action=>"index"
  end
end

