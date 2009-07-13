class Ecm::FormulariosController < ApplicationController
  def index
    @categoria = Formulariocategoria.find(params[:categoria_id])
    @formularios = Formulario.da_categoria(params[:categoria_id]).find(:all)
  end

  def show
    @categoria = Formulariocategoria.find(params[:categoria_id])
    @formulario = Formulario.find(params[:id])
  end

  def new
    @categoria = Formulariocategoria.find(params[:categoria_id])
    @formulario = Formulario.new
  end

  def create
    @categoria = Formulariocategoria.find(params[:categoria_id])
    @formulario = Formulario.new(params[:formulario])
    @formulario.formulariocategoria_id = params[:categoria_id]
	  if @formulario.save
	    flash[:notice] = "Formulario Criado com Sucesso!"
      redirect_to :action=>"show",:id=>@formulario.id
    else
       render :action => "new"
    end
  end

  def edit
    @categoria = Formulariocategoria.find(params[:categoria_id])
    @formulario = Formulario.find(params[:id])
  end

  def update
    @categoria = Formulariocategoria.find(params[:categoria_id])
    @formulario = Formulario.find(params[:id])
    if @formulario.update_attributes(params[:formulario])
      flash[:notice] = "Formulario Atualizado com Sucesso!"
      redirect_to :action=>"show",:id=>@formulario.id
    else
       render :action=> :edit, :id=>@formulario
    end
  end

  def principal
    @formulario = Formulario.find(params[:id])
    @itens = Itensformulario.do_formulario(params[:id]).do_tipo("texto").find(:all)
  end
end

