class Wiki::WikicategoriasController < ApplicationController
  skip_before_filter :autorizado

  def index
    @wikicategorias = Wikicategoria.raiz.da_entidade(@sessao_usuario.entidade_id).find(:all)
  end

  def show
    @wikicategoria = Wikicategoria.find(params[:id])
    @wikicategorias = Wikicategoria.find(:all, :conditions=>["parent_id = ?", params[:id]])
    @wikipages = Wikipage.da_entidade(@sessao_usuario.entidade_id).da_categoria(params[:id]).find(:all)
  end

  def new
    unless params[:wikicategoria_id]
      @wikicategorias = Wikicategoria.raiz.da_entidade(@sessao_usuario.entidade_id).find(:all)
    else
      @wikicategoria = Wikicategoria.find(params[:wikicategoria_id])
      @wikicategorias = Wikicategoria.da_entidade(@sessao_usuario.entidade_id).find(:all, :conditions=>["parent_id = ?", params[:wikicategoria_id]])
    end
    render :update do |page|
      page.visual_effect(:highlight , 'categorias')
      page.replace_html "categorias", render(:partial => "new")
    end
  end


  def create
    @wikicategoria = Wikicategoria.new
    @wikicategoria.nome = params[:nome]
    @wikicategoria.entidade_id = @sessao_usuario.entidade_id
    @wikicategoria.parent_id = params[:wikicategoria_id] if params[:wikicategoria_id]
	  if @wikicategoria.save
	    @wikicategorias = Wikicategoria.raiz.da_entidade(@sessao_usuario.entidade_id).find(:all)
	    render :update do |page|
	      if params[:wikicategoria_id]
	        @wikicategoria = Wikicategoria.find(params[:wikicategoria_id])
          @wikicategorias = Wikicategoria.da_entidade(@sessao_usuario.entidade_id).find(:all, :conditions=>["parent_id = ?", params[:wikicategoria_id]])
        else
          @wikicategorias = Wikicategoria.raiz.da_entidade(@sessao_usuario.entidade_id).find(:all)
        end
        page.visual_effect(:highlight , 'categorias')
        page.replace_html "categorias", render(:partial => "categorias")
      end
    else
       render :action => "new"
    end
  end

  def edit
    @wikicategoria = Wikicategoria.find(params[:id])
  end

  def update
    @wikicategoria = Wikicategoria.find(params[:id])
    if @wikicategoria.update_attributes(params[:wikicategoria])
      flash[:notice] = "Categoria Atualizada com Sucesso!"
      redirect_to :action=>"show",:id=>@wikicategoria.id
    else
       render :action=> :edit, :id=>@wikicategoria
    end
  end

  def busca
    unless params[:wikicategoria_id]
      @wikipages = Wikipage.da_entidade(@sessao_usuario.entidade_id).find(:all, :conditions=>["titulo like ? or conteudo like ?","%#{params[:filtro]}%", "%#{params[:filtro]}%"])
    else
      @wikipages = Wikipage.da_entidade(@sessao_usuario.entidade_id).da_categoria(params[:wikicategoria_id]).find(:all, :conditions=>["titulo like ? or conteudo like ?","%#{params[:filtro]}%", "%#{params[:filtro]}%"])
    end
    render :update do |page|
      page.visual_effect(:highlight , 'busca_wiki')
      page.replace_html "busca_wiki", render(:partial => "busca_wiki")
    end
  end
end

