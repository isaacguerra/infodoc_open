class Core::GruposistemasController < ApplicationController
  def index
    @grupo = Grupo.find(params[:admingrupo_id])
    if @grupo.gruposistemas.size > 0
      sd = @grupo.gruposistemas.collect {|s| s.sistema_id}
      @sistemas = Sistema.find(:all, {:conditions=>["modulo_id in (?) and id not in (?)", @sessao_usuario.entidade.moduloentidades.collect {|me| me.modulo_id}, sd]})
    else
      @sistemas = Sistema.find(:all, {:conditions=>["modulo_id in (?)", @sessao_usuario.entidade.moduloentidades.collect {|me| me.modulo_id}]})
    end
  end

  def create
    if params[:sistemas]
      if params[:commit] == "Adicionar"
        params[:sistemas].each {|s| Gruposistema.create(:sistema_id=>s, :grupo_id=>params[:admingrupo_id])}
        flash[:notice] = "Sistema (s) Adicionado (s) ao Grupo!"
      else
        params[:sistemas].each {|s| Gruposistema.find(s).destroy}
        flash[:notice] = "Sistema (s) Retirado (s) do Grupo!"
      end
    end
    redirect_to core_admingrupo_gruposistemas_path(params[:admingrupo_id])
  end
end

