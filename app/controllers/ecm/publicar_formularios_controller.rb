class Ecm::PublicarFormulariosController < ApplicationController
  skip_before_filter :autorizado

  def index
    @formulario = Formulario.find(params[:formulario_id])
  end

  def show
  end

  def new
    @formulario = Formulario.find(params[:formulario_id])
    @cadastropublico = Cadastropublico.new
  end

  def create
    @formulario = Formulario.find(params[:formulario_id])
    @cadastropublico = Cadastropublico.new(params[:cadastropublico])
    @cadastropublico.titulo = @formulario.titulo
    @cadastropublico.permissao = 0
    filtro = []
    filtro << params[:cadastro]
    filtro << params[:filtro]
    @cadastropublico.filtro  = filtro
    if @cadastropublico.save
      flash[:notice] = "Formulario publicado com sucesso"
      redirect_to ecm_formulario_publicar_formularios_path(@formulario)
    else
      render :action=>new, :formulario_id=>@formulario.id
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @formulario = Formulario.find(params[:formulario_id])
    @cadastropublico = Cadastropublico.find(params[:id])
    @cadastropublico.destroy
    flash[:notice] = "Publicação removida com com sucesso"
    redirect_to ecm_formulario_publicar_formularios_path(@formulario)
  end
end

