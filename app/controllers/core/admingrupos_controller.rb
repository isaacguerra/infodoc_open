class Core::AdmingruposController < ApplicationController
  def index
    @grupos = Grupo.find(:all, {:conditions=>["entidade_id = ?", @sessao_usuario.entidade_id]})
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
	    flash[:notice] = "Grupo Criado com Sucesso!"
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
      flash[:notice] = "Grupo Atualizado com Sucesso!"
      redirect_to :action=>"show",:id=>@grupo.id
    else
       render :action=> :edit, :id=>@grupo
    end
  end
end

