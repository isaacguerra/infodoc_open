class Page::HomeentidadesController < ApplicationController
  skip_filter :autorizado

  def edit
    @paginaentidade = Paginaentidade.find(:first, :conditions=>["entidade_id=? and tipo = 'home'", @sessao_usuario.entidade_id])
  end

  def update
    @paginaentidade = Paginaentidade.find(:first, :conditions=>["entidade_id=? and tipo = 'home'", @sessao_usuario.entidade_id])
    if @paginaentidade.update_attributes(params[:paginaentidade])
      flash[:notice] = "Pagina Atualizada com Sucesso!"
      redirect_to core_perfilentidades_path
    else
       render :action=> :edit, :id=>@paginaentidade
    end
  end
end

