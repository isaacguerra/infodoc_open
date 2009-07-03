class Core::EntidadesController < ApplicationController
  def index
    @entidades = Entidade.find :all
  end

  def show
    @entidade = Entidade.find params[:id]
  end

  def new
    @entidade = Entidade.new
  end

  def create
    @entidade = Entidade.new(params[:entidade])
    @entidade.status = true
    if @entidade.save
       redirect_to core_entidade_path(@entidade)
    else
       render :action => "new"
    end
  end

  def edit
    @entidade = Entidade.find(params[:id])
  end

  def update
    @entidade = Entidade.find(params[:id])
    if @entidade.update_attributes(params[:entidade])
      redirect_to core_entidade_path(@entidade)
    else
       render :action=>:edit, :id=>@entidade
    end
  end

  def mudar_status
    @entidade = Entidade.find(params[:id])
    if @entidade.status
      @entidade.status = false
    else
      @entidade.status = true
    end
    @entidade.save
    render :action=> :show, :id=>@entidade
  end
end

