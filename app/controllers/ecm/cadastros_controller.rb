class Ecm::CadastrosController < ApplicationController
  def index
    @cadastros = Cadastro.do_formulario(params[:formulario_id]).find(:all)
  end

  def show
    @categoria = Formulariocategoria.find(params[:id])
  end

  def new
    @categoria = Formulariocategoria.new
  end

  def create
    @categoria = Formulariocategoria.new(params[:formulariocategoria])
	  if @categoria.save
	    flash[:notice] = "Categoria Criada com Sucesso!"
      redirect_to :action=>"show",:id=>@categoria.id
    else
       render :action => "new"
    end
  end

  def edit
    @categoria = Formulariocategoria.find(params[:id])
  end

  def update
    @categoria = Formulariocategoria.find(params[:id])
    if @categoria.update_attributes(params[:formulariocategoria])
      flash[:notice] = "Categoria Atualizada com Sucesso!"
      redirect_to :action=>"show",:id=>@categoria.id
    else
       render :action=> :edit, :id=>@categoria
    end
  end

end

