class Ecm::ComentariosController < ApplicationController
  skip_before_filter :autorizado

  def index
    @cadastro = Cadastro.find(params[:cadastro_id])
    render :update do |page|
      page.visual_effect(:highlight , "comentarios")
      page.replace_html "comentarios", render(:partial=>"index")
    end
  end

  def new
    @cadastro = Cadastro.find(params[:cadastro_id])
    render :update do |page|
      page.visual_effect(:highlight , "new_comentario")
      page.replace_html "new_comentario", render(:partial=>"new")
    end
  end

  def create
    @cadastro = Cadastro.find(params[:cadastro_id])
    comentario = Comentario.new(:usuario_id=>@sessao_usuario.usuario_id, :entidade_id=>@sessao_usuario.usuario_id, :conteudo=>params[:comentario])
    @cadastro.comentarios << comentario
    redirect_to ecm_cadastro_comentarios_path(@cadastro)
  end

  def clean
    render :update do |page|
      page.replace_html "comentarios", render(:text=>"")
    end
  end
end

