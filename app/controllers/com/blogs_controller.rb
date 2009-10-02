class Com::BlogsController < ApplicationController
  def index
    ub = @sessao_usuario.usuario.usuario_blogs.collect {|ub| ub.seguido_id}
    if ub.size > 0
      @usuarios = Usuario.da_entidade(@sessao_usuario.entidade_id).ativo.find(:all, :conditions=>["id != ? and id not in (?)", @sessao_usuario.usuario_id, ub])
    else
      @usuarios = Usuario.da_entidade(@sessao_usuario.entidade_id).ativo.find(:all, :conditions=>["id != ?", @sessao_usuario.usuario_id])
    end
    @seguidores = UsuarioBlog.da_entidade(@sessao_usuario.entidade_id).seguidores_de(@sessao_usuario.usuario_id)
  end

  def usuario_blogs
    if params[:usuarios]
      if params[:commit] == "Adicionar"
        params[:usuarios].each {|u| UsuarioBlog.create(:entidade_id=>@sessao_usuario.entidade_id, :usuario_id=>@sessao_usuario.usuario_id, :seguido_id=>u)}
        flash[:notice] = "Usuario (s) Adicionado(s) com Sucesso!"
      else
        params[:usuarios].each {|u| UsuarioBlog.find(u).destroy}
        flash[:notice] = "Usuario (s) Retirado(s) com Sucesso!"
      end
    end
    redirect_to com_blogs_path
  end

  def create
    Blog.create(:entidade_id=>@sessao_usuario.entidade_id, :usuario_id=>@sessao_usuario.usuario_id, :menssagem=>params[:menssagem])
    render show
  end

  def show
    @menssagens = Blog.busca_menssagem(@sessao_usuario.usuario_id)
  end
end

