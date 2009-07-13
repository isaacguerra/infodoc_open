class Ecm::CadastrosController < ApplicationController
  def index
    @formulario = Formulario.find(params[:formulario_id])
  end

  def show
    @formulario = Formulario.find(params[:formulario_id])
    @cadastro = Cadastro.find(params[:id])
  end

  def new
    @formulario = Formulario.find(params[:formulario_id])
    @cadastro = Cadastro.new
    @cadastro.monta_acessores(@formulario)
  end

  def create
    @formulario = Formulario.find(params[:formulario_id])
    @cadastro = Cadastro.new()
    @cadastro.monta_acessores(@formulario)
    @cadastro.validar(@formulario, params[:cadastro])
    if @cadastro.errors.count > 0
      render :action => "new"
    else
      @cadastro.entidade_id = params[:cadastro][:entidade_id]
      @cadastro.formulario_id = params[:cadastro][:formulario_id]
      @cadastro.formulariocategoria_id = params[:cadastro][:formulariocategoria_id]
      @cadastro.formulariotipo_id = params[:cadastro][:formulariotipo_id]
      @cadastro.usuario_id = params[:cadastro][:usuario_id]
      @cadastro.save
      @cadastro.salvar_itens(params[:cadastro])
      flash[:notice] = "Categoria Criada com Sucesso!"
      redirect_to :action=>"show",:id=>@cadastro.id
    end
  end

  def edit
    @formulario = Formulario.find(params[:formulario_id])
    @cadastro = Cadastro.find(params[:id])
    @cadastro.monta_acessores(@formulario)
  end

  def update
    @formulario = Formulario.find(params[:formulario_id])
    @cadastro = Cadastro.find(params[:id])
    @cadastro.monta_acessores(@formulario)
    @cadastro.validar(@formulario, params[:cadastro])
    if @cadastro.errors.count > 0
      render :action => "edit", :id=>@cadastro
    else
      @cadastro.update_itens(params[:cadastro])
      flash[:notice] = "Categoria Criada com Sucesso!"
      redirect_to :action=>"show",:id=>@cadastro.id
    end
  end

  def busca
    @formulario = Formulario.find(params[:id])
    @item = Itensformulario.find(@formulario.principal_id)
    @cadastros = EcmItemTexto.do_formulario(@formulario.id).do_itens_formulario(@formulario.principal_id).find(:all, :conditions=>["conteudo like ?", "%#{params[:filtro]}%"])
    render :update do |page|
      page.visual_effect(:highlight , 'cadastros')
      page.replace_html "cadastros", render(:partial => "filtro")
    end
  end

end

