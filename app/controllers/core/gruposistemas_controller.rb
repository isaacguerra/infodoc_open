class Core::GruposistemasController < ApplicationController
  def index
    sv = []
    @sessao_usuario.usuario.entidade.moduloentidades.each do |me|
      me.modulo.sistemas.each {|s| sv << s.id}
    end
    @gruposistemas = Gruposistema.find(:all, {:conditions=>["grupo_id = ? ", params[:admingrupo_id]]}).collect {|s| s if sv.include?(s.sistema_id)}.compact

    if @gruposistemas.size > 0
      @gruposistemas.collect {|u| sv.delete(u.sistema_id)}
      @sistemas = Sistema.all.collect {|sf| sf if sv.include?(sf.id)}.compact!
    else
      @sistemas = Sistema.all.collect {|sf| sf if sv.include?(sf.id)}.compact!
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

