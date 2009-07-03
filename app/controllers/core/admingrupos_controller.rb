class Core::AdmingruposController < ApplicationController
  def index
    @grupos = Grupo.find(:all, :conditions=>{:entidade_id=>@sessao_usuario.usuario.entidade_id})
  end

  def show
    @grupo = Grupo.find params[:id]
  end

  def new
    @grupo = Grupo.new
  end

  def create
    @grupo = Grupo.new(params[:grupo])
	  if @grupo.save
       redirect_to :action=>"show",:id=>@grupo.id
    else
       render :action => "new"
    end
  end

  def edit
    @grupo = Grupo.find(params[:id])
  end

  def update
    @grupo = Grupo.find(params[:id])
    if @grupo.update_attributes(params[:grupo])
      redirect_to :action=>"show",:id=>@grupo.id
    else
       render :action=> :edit, :id=>@grupo
    end
  end
end

