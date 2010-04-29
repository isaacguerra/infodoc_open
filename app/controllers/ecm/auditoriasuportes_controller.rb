class Ecm::AuditoriasuportesController < ApplicationController
  def index
    @auditoriasuportes = Auditoriasuporte.da_entidade(@sessao_usuario.entidade_id).do_usuario(@sessao_usuario.usuario_id).find(:all, :order=>"created_at desc")
  end

  def show
    @auditoriasuporte = Auditoriasuporte.find(params[:id])
  end

  def new
    @auditoriasuporte = Auditoriasuporte.new
  end

  def create
    @auditoriasuporte = Auditoriasuporte.new(params[:auditoriasuporte])
	  if @auditoriasuporte.save
	    flash[:notice] = "Suporte Criado com Sucesso!"
      redirect_to :action=>"show",:id=>@auditoriasuporte.id
    else
       render :action => "new"
    end
  end

  def update
    @auditoriasuporte = Auditoriasuporte.find(params[:id])
    @auditoriasuporte.auditado = true
    @auditoriasuporte.auditor_id = @sessao_usuario.usuario_id
    @auditoriasuporte.save
    render :update do |page|
      page.visual_effect(:highlight , "audi_#{params[:id]}")
      page.replace_html "audi_#{params[:id]}", render(:text=>"auditado")
    end
  end
end

