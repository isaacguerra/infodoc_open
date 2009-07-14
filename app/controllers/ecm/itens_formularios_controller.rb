class Ecm::ItensFormulariosController < ApplicationController
  def index
    @formulario = Formulario.find(params[:formulario_id])
    @form_itens = Itensformulario.do_formulario(params[:formulario_id]).find(:all)
  end

  def show
    @formulario = Formulario.find(params[:formulario_id])
    @form_item = Itensformulario.find(params[:id])
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
    @form_item.opcoes = params[:opcoes]
	  if @form_item.save
	    flash[:notice] = "Item Criado com Sucesso!"
      redirect_to :action=>"show",:id=>@form_item.id
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
    if @form_item.update_attributes(params[:itensformulario])
      flash[:notice] = "Item Atualizado com Sucesso!"
      redirect_to :action=>"show",:id=>@form_item.id
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
end

