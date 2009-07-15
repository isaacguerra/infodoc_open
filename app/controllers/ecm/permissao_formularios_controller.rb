class Ecm::PermissaoFormulariosController < ApplicationController
  def index
    @formulario = Formulario.find(params[:formulario_id])
    @gd = Grupoformulario.do_formulario(params[:formulario_id])
    if @gd.size > 0
      @gf = Grupo.ativo.da_entidade(@sessao_usuario.entidade_id).find(:all, :conditions=>["id not in (?)", @gd.collect {|g| g.grupo_id}])
    else
      @gf = Grupo.ativo.da_entidade(@sessao_usuario.entidade_id).find(:all)
    end
  end

  def create
    if params[:commit] == "Remover"
      if params[:grupos]
        params[:grupos].each {|g| Grupoformulario.find(g).destroy}
        flash[:notice] = "Grupo(s) removidos com sucesso!"
      end
    end

    if params[:commit] == "Adicionar"
      if params[:perm].size > 0
        params[:perm].each do |k,v|
          if v.to_i > 0
            Grupoformulario.create(:grupo_id=>k, :permissao=>v, :formulario_id=>params[:formulario_id])
          end
        end
        flash[:notice] = "Grupo(s) adicionados com sucesso!"
      end
    end
    redirect_to ecm_formulario_permissao_formularios_path(params[:formulario_id])
  end
end

