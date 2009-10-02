class Wiki::WikipagesController < ApplicationController
  skip_before_filter :autorizado


  def show
    @wikicategoria = Wikicategoria.find(params[:wikicategoria_id])
    @wikipage = Wikipage.find(params[:id])
  end

  def new
    @wikicategoria = Wikicategoria.find(params[:wikicategoria_id])
    @wikipage = Wikipage.new
  end

  def create
    @wikicategoria = Wikicategoria.find(params[:wikicategoria_id])
    @wikipage = Wikipage.new(params[:wikipage])
	  if @wikipage.save
	    Wikihistoriapage.create(:wikipage_id=>@wikipage.id, :usuario_id=>@sessao_usuario.usuario_id)
	    flash[:notice] = "Pagina Criada com Sucesso!"
      redirect_to wiki_wikicategoria_path(@wikicategoria)
    else
       render :action => "new", :wikicategoria_id=>@wikicategoria
    end
  end

  def edit
    @wikicategoria = Wikicategoria.find(params[:wikicategoria_id])
    @wikipage = Wikipage.find(params[:id])
  end

  def update
    @wikicategoria = Wikicategoria.find(params[:wikicategoria_id])
    @wikipage = Wikipage.find(params[:id])
    conteudo = @wikipage.conteudo
    if @wikipage.update_attributes(params[:wikipage])
      Wikihistoriapage.create(:wikipage_id=>@wikipage.id, :usuario_id=>@sessao_usuario.usuario_id, :conteudo_antigo=>conteudo)
      flash[:notice] = "Pagina Atualizada com Sucesso!"
      redirect_to wiki_wikicategoria_wikipage_path(@wikicategoria, @wikipage)
    else
       render :action=> :edit, :wikicategoria_id=>@wikicategoria
    end
  end
end

