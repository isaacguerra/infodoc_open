class Core::SistemasController < ApplicationController
  def index
    @modulo = Modulo.find params[:modulo_id]
    @sistema = Sistema.find(:all, :conditions=>{:modulo_id=>params[:modulo_id]})
  end

  def show
    @modulo = Modulo.find params[:modulo_id]
    @sistema = Sistema.find params[:id]
  end

  def new
    @modulo = Modulo.find params[:modulo_id]
    @sistema = Sistema.new
  end

  def create
    @sistema = Sistema.new(params[:sistema])
    @sistema.modulo_id = params[:modulo_id]
    @sistema.status = true
	  if @sistema.save
       redirect_to :controller=>"sistemas",:action=>"show",:id=>@sistema.id
    else
       render :action => "new"
    end
  end

  def edit
    @modulo = Modulo.find(params[:modulo_id])
    @sistema = Sistema.find(params[:id])
  end

  def update
    @sistema = Sistema.find(params[:id])
    if @sistema.update_attributes(params[:sistema])
      redirect_to :controller=>"sistemas",:action=>"show",:id=>@sistema.id
    else
       render :action=> :edit, :id=>@sistema
    end
  end
end

