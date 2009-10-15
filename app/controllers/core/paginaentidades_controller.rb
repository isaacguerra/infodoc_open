class Core::PaginaentidadesController < ApplicationController

  def new
    @entidade = Entidade.find params[:entidade_id]
    @paginaentidade = Paginaentidade.new
  end

  def create
    @paginaentidade = Paginaentidade.new(params[:paginaentidade])
	  if @paginaentidade.save
	    flash[:notice] = "Pagina Criada com Sucesso!"
      redirect_to '/intranet'
    else
       render :action => "new"
    end
  end

  def edit
    @entidade = Entidade.find params[:entidade_id]
    @paginaentidade = Paginaentidade.find(params[:id])
  end

  def update
    @entidade = Entidade.find params[:entidade_id]
    @paginaentidade = Paginaentidade.find(params[:id])
    if @paginaentidade.update_attributes(params[:paginaentidade])
      flash[:notice] = "Pagina Atualizada com Sucesso!"
      redirect_to '/intranet'
    else
       render :action=> :edit, :id=>@paginaentidade
    end
  end

  def destroy
    @entidade = Entidade.find params[:entidade_id]
    @paginaentidade = Paginaentidade.find(params[:id])
    @paginaentidade.destroy
    flash[:notice] = "Pagina Excluida com Sucesso!"
    redirect_to '/intranet'
  end
end

