class Ecm::AjudasFormulariosController < ApplicationController
  def index
    @formulario = Formulario.find(params[:formulario_id])
  end

  def show
    @formulario = Formulario.find(params[:formulario_id])
    @ajuda = Ajuda.find(params[:id])
  end

  def new
    @formulario = Formulario.find(params[:formulario_id])
    @ajuda = Ajuda.new
  end

  def create
    @formulario = Formulario.find(params[:formulario_id])
    @ajuda = Ajuda.new(params[:ajuda])
	  if @ajuda.save
	    @formulario.ajudas << @ajuda
	    flash[:notice] = "Ajuda Criado com Sucesso!"
      redirect_to ecm_formulario_ajudas_formularios_path(@formulario)
    else
       render :action => "new", :formulario_id=>@formulario
    end
  end

  def edit
    @formulario = Formulario.find(params[:formulario_id])
    @ajuda = Ajuda.find(params[:id])
  end

  def update
    @formulario = Formulario.find(params[:formulario_id])
    @ajuda = Ajuda.find(params[:id])
    if @ajuda.update_attributes(params[:ajuda])
      flash[:notice] = "Ajuda Atualizada com Sucesso!"
      redirect_to ecm_formulario_ajudas_formularios_path(@formulario)
    else
       render :action=> :edit, :formulario_id=>@formulario
    end
  end
end

