class Core::GrupousuariosController < ApplicationController
  def index
    @grupo = Grupo.find(params[:admingrupo_id])
    if @grupo.grupousuarios.size > 0
      ud = @grupo.grupousuarios.collect {|u| u.usuario_id}
      @usuarios = Usuario.find(:all, :conditions=>{:entidade_id=>@sessao_usuario.usuario.entidade_id}).collect {|uf| uf unless ud.include?(uf.id)}.compact!
    else
      @usuarios = Usuario.find(:all, :conditions=>{:entidade_id=>@sessao_usuario.usuario.entidade_id})
    end
  end

  def create
    if params[:usuarios]
      if params[:commit] == "Adicionar"
        params[:usuarios].each {|u| Grupousuario.create(:usuario_id=>u, :grupo_id=>params[:admingrupo_id])}
        flash[:notice] = "Usuario (s) Adicionado (s) ao Grupo!"
      else
        params[:usuarios].each {|u| Grupousuario.find(u).destroy}
        flash[:notice] = "Usuario (s) Retirado (s) do Grupo!"
      end
    end
    redirect_to core_admingrupo_grupousuarios_path(params[:admingrupo_id])
  end
end

