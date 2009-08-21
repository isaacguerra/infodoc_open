class Wiki::WikicomentariosController < ApplicationController
  def index
    @wikipage = Wikipage.find(params[:wikipage_id])
    render :update do |page|
      page.visual_effect(:highlight , "comentarios")
      page.replace_html "comentarios", render(:partial=>"index")
    end
  end

  def new
    @wikipage = Wikipage.find(params[:wikipage_id])
    render :update do |page|
      page.visual_effect(:highlight , "new_comentario")
      page.replace_html "new_comentario", render(:partial=>"new")
    end
  end

  def create
    @wikipage = Wikipage.find(params[:wikipage_id])
    comentario = Comentario.new(:usuario_id=>@sessao_usuario.usuario_id, :entidade_id=>@sessao_usuario.usuario_id, :conteudo=>params[:comentario])
    @wikipage.comentarios << comentario
    redirect_to wiki_wikipage_wikicomentarios_path(@wikipage)
  end

  def clean
    render :update do |page|
      page.replace_html "comentarios", render(:text=>"")
    end
  end
end

