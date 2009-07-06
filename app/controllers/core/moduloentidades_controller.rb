class Core::ModuloentidadesController < ApplicationController
  def index
    @entidade = Entidade.find(params[:entidade_id])
    if @entidade.moduloentidades.size > 0
      md = @entidade.moduloentidades.collect {|u| u.modulo_id}
      @modulos = Modulo.all.collect {|mf| mf unless md.include?(mf.id)}.compact!
    else
      @modulos = Modulo.all
    end
  end

  def create
    if params[:modulos]
      if params[:commit] == "Adicionar"
        params[:modulos].each {|m| Moduloentidade.create(:modulo_id=>m, :entidade_id=>params[:entidade_id])}
        flash[:notice] = "Entidade (s) Adicionada (s) ao Módulo!"
      else
        params[:modulos].each {|m| Moduloentidade.find(m).destroy}
        flash[:notice] = "Entidade (s) Retirada (s) ao Módulo!"
      end
    end
    redirect_to core_entidade_moduloentidades_path(params[:entidade_id])
  end
end

