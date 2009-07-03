class Core::ModulosController < ApplicationController
  def index
    @modulos = Modulo.find :all
  end

  def show
    @modulo = Modulo.find params[:id]
  end

  def new
    @modulo = Modulo.new
  end

  def create
    @modulo = Modulo.new(params[:modulo])
    if @modulo.save
       redirect_to core_modulo_path(@modulo)
    else
       render :action => "new"
    end
  end

  def edit
    @modulo = Modulo.find(params[:id])
  end

  def update
    @modulo = Modulo.find(params[:id])
    if @modulo.update_attributes(params[:modulo])
      redirect_to core_modulo_path(@modulo)
    else
       render :action=>:edit, :id=>@modulo
    end
  end
end

