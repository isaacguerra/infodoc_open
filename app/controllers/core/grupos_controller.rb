class Core::GruposController < ApplicationController
  def index
    @entidade = Entidade.find(params[:entidade_id])
    @grupos = Grupo.find(:all, :conditions=>{:entidade_id=>params[:entidade_id]})
  end

  def show
    @entidade = Entidade.find(params[:entidade_id])
    @grupo = Grupo.find params[:id]
  end

  def new
    @entidade = Entidade.find params[:entidade_id]
    @grupo = Grupo.new
  end

  def create
    @grupo = Grupo.new(params[:grupo])
	  if @grupo.save
       redirect_to :controller=>"grupos",:action=>"show",:id=>@grupo.id
    else
       render :action => "new"
    end
  end

  def edit
    @entidade = Entidade.find params[:entidade_id]
    @grupo = Grupo.find(params[:id])
  end

  def update
    @entidade = Entidade.find params[:entidade_id]
    @grupo = Grupo.find(params[:id])
    if @grupo.update_attributes(params[:grupo])
      redirect_to :controller=>"grupos",:action=>"show",:id=>@grupo.id
    else
       render :action=> :edit, :id=>@grupo
    end
  end
end

