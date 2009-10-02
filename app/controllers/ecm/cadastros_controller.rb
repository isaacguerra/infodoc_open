class Ecm::CadastrosController < ApplicationController
  def index
    @formulario = Formulario.find(params[:formulario_id])
    if @formulario.permissao(@sessao_usuario.usuario) < 1
      flash[:notice] = "Ação não Autorizada"
      redirect_to "/intranet"
    end
  end

  def show
    @formulario = Formulario.find(params[:formulario_id])
    @cadastro = Cadastro.find(params[:id])
    if @formulario.permissao(@sessao_usuario.usuario) < 1
      flash[:notice] = "Ação não Autorizada"
      redirect_to "/intranet"
    end
  end

  def new
    @formulario = Formulario.find(params[:formulario_id])
    @cadastro = Cadastro.new
    @cadastro.monta_acessores(@formulario)
    if @formulario.permissao(@sessao_usuario.usuario) < 2
      flash[:notice] = "Ação não Autorizada"
      redirect_to "/intranet"
    end
  end

  def create
    @formulario = Formulario.find(params[:formulario_id])
    @cadastro = Cadastro.new()
    @cadastro.monta_acessores(@formulario)
    @cadastro.validar(@formulario, params[:cadastro])
    if @cadastro.errors.count > 0
      @params = params[:cadastro]
      render :action => "new"
    else
      @cadastro.entidade_id = params[:cadastro][:entidade_id]
      @cadastro.formulario_id = params[:cadastro][:formulario_id]
      @cadastro.formulariocategoria_id = params[:cadastro][:formulariocategoria_id]
      @cadastro.formulariotipo_id = params[:cadastro][:formulariotipo_id]
      @cadastro.usuario_id = params[:cadastro][:usuario_id]
      @cadastro.save
      @cadastro.salvar_itens(params[:cadastro])
      flash[:notice] = "Cadastro Criado com Sucesso!"
      redirect_to :action=>"show",:id=>@cadastro.id
    end
  end

  def edit
    @formulario = Formulario.find(params[:formulario_id])
    @cadastro = Cadastro.find(params[:id])
    @cadastro.monta_acessores(@formulario)
    if @formulario.permissao(@sessao_usuario.usuario) < 2
      flash[:notice] = "Ação não Autorizada"
      redirect_to "/intranet"
    end
  end

  def update
    @formulario = Formulario.find(params[:formulario_id])
    @cadastro = Cadastro.find(params[:id])
    @cadastro.monta_acessores(@formulario)
    @cadastro.validar(@formulario, params[:cadastro])
    if @cadastro.errors.count > 0
      @params = params[:cadastro]
      render :action => "edit", :id=>@cadastro
    else
      @cadastro.update_itens(params[:cadastro])
      flash[:notice] = "Cadastro Alterado com Sucesso!"
      redirect_to :action=>"show",:id=>@cadastro.id
    end
  end

  def busca
    @formulario = Formulario.find(params[:id])
    @principal = Itensformulario.find(@formulario.principal_id)
    @cadastro_itens = EcmItemTexto.do_formulario(@formulario.id).do_itens_formulario(@formulario.principal_id).find(:all, :conditions=>["conteudo like ?", "%#{params[:filtro]}%"])
    @tipo = params[:tipo]
    render :update do |page|
      page.visual_effect(:highlight , 'cadastros')
      page.replace_html "cadastros", render(:partial => "filtro")
    end
  end

  def view_busca_avancada
    @formulario = Formulario.find(params[:id])
    render :update do |page|
      page.visual_effect(:highlight , 'busca')
      page.replace_html "busca", render(:partial => "busca_avancada")
    end
  end

  def view_busca
    @formulario = Formulario.find(params[:id])
    render :update do |page|
      page.visual_effect(:highlight , 'busca')
      page.replace_html "busca", render(:partial => "busca")
    end
  end

  def busca_avancada
    @formulario = Formulario.find(params[:id])
    @principal = Itensformulario.find(@formulario.principal_id)
    @cads = []
    @res = []
    @formulario.itensformularios.each do |form_item|
      if params[:filtro]["check_#{form_item.id}"] == "1"
        filtro = eval("#{form_item.itenstipo.componente.camelize}EcmBase.new")
        @cads << filtro.busca_avancada(form_item, params)
        if @cads.size > 0
          @res = @cads[0]
          @cads.each do |c|
            @res = @res & c
          end
        end
      end
    end
    @cadastro_itens = EcmItemTexto.do_formulario(@formulario.id).do_itens_formulario(@formulario.principal_id).find(:all, :conditions=>["cadastro_id in (?)", @res])
    @tipo = params[:tipo]
#     params[:pdf]
      render :update do |page|
        page.visual_effect(:highlight , 'cadastros')
        page.replace_html "cadastros", render(:partial => "filtro")
      end
#    else
#      send_data render_to_pdf({:action =>'_filtro.html.erb'})
#    end
  end

  def ajax
    @formulario = Formulario.find(params[:formulario_id])
    @item = Itensformulario.find(params[:item_id])
    render :update do |page|
      page.visual_effect(:highlight , params[:div])
      page.replace_html params[:div], render(:text=> ecm_ajax(@item.itenstipo.componente, @item, params))
    end
  end

  def destroy
    @cadastro = Cadastro.find(params[:id])
    if @cadastro.formulario.permissao(@sessao_usuario.usuario) > 2
      @cadastro.destroy
      flash[:notice] = "Cadastro Excluido com Sucesso!"
      redirect_to ecm_formulario_cadastros_path(@cadastro.formulario_id)
    else
      flash[:notice] = "impossivel excluir o cadastro"
      redirect_to ecm_formulario_cadastro_path(@cadastro.formulario_id, @cadastro)
    end
  end
end

