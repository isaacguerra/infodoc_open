class Ecm::ItensFormulariosController < ApplicationController
  def index
    @formulario = Formulario.find(params[:formulario_id])
    @form_itens = Itensformulario.do_formulario(params[:formulario_id]).find(:all, :order=>"posicao")
  end

  def show
    @formulario = Formulario.find(params[:formulario_id])
    @form_item = Itensformulario.find(params[:id])
    if params[:acao]
      if params[:acao] == "sobe"
        @form_item.sobeposicao
      else
        @form_item.desceposicao
      end
      redirect_to ecm_formulario_itens_formularios_path(@formulario)
    end
  end

  def new
    @formulario = Formulario.find(params[:formulario_id])
    @form_item = Itensformulario.new
  end

  def create
    @formulario = Formulario.find(params[:formulario_id])
    @itenstipo = Itenstipo.find(params[:itensformulario][:itenstipo_id])
    @form_item = Itensformulario.new(params[:itensformulario])
    @form_item.tipo = @itenstipo.tipo
    @form_item.componente = @itenstipo.componente
    @form_item.opcoes = params[:opcoes]
    if @form_item.validar_opcoes
	    if @form_item.salvar_item(@itenstipo, params)
	      flash[:notice] = "Item Criado com Sucesso!"
        redirect_to :action=>"show",:id=>@form_item.id
      else
         render :action => "new"
      end
    else
      render :action => "new"
    end
  end

  def edit
    @formulario = Formulario.find(params[:formulario_id])
    @form_item = Itensformulario.find(params[:id])
  end

  def update
    @formulario = Formulario.find(params[:formulario_id])
    @form_item = Itensformulario.find(params[:id])
    @form_item.opcoes = params[:opcoes]
    if @form_item.validar_opcoes
      if @form_item.update_attributes(params[:itensformulario])
        if @form_item.salvar_item(@form_item.itenstipo, params)
	        flash[:notice] = "Item Criado com Sucesso!"
          redirect_to :action=>"show",:id=>@form_item.id
        else
        render :action=> :edit, :id=>@form_item
        end
      else
         render :action=> :edit, :id=>@form_item
      end
    else
      render :action=> :edit, :id=>@form_item
    end
  end

  def montaformitem
    @itenstipo = Itenstipo.find(params[:itenstipo_id])
    render :update do |page|
      page.visual_effect(:highlight , 'form_item')
      page.replace_html "form_item", render(:text=>ecm_new_form_item(@itenstipo.componente))
    end
  end

  def ajax
    render :update do |page|
      @itenstipo = Itenstipo.find(params[:id])
      page.visual_effect(:highlight , 'ajax_item')
      page.replace_html "ajax_item", render(:text=>ecm_form_item_ajax(@itenstipo, params))
    end
  end
end

