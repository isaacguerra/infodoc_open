class Ecm::PrincipalFormulariosController < ApplicationController
  def index
    @formulario = Formulario.find(params[:formulario_id])
    @itens = Itensformulario.do_formulario(params[:formulario_id]).do_tipo("texto").find(:all)
  end

  def show
    @formulario = Formulario.find(params[:formulario_id])
    @formulario.principal_id = params[:id]
	  @formulario.save
	    flash[:notice] = "Principal definido com Sucesso!"
      redirect_to ecm_categoria_formularios_path(@formulario.formulariocategoria_id)
  end
end

