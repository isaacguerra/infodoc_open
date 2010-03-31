class Core::AuditoriasController < ApplicationController
  skip_before_filter :autorizado

  def index
    @usuario = Usuario.find(params[:adminusuario_id])
    @formularios = Formulario.da_entidade(@sessao_usuario.entidade_id).find(:all, :select=>"titulo, id").collect {|f| [f.titulo, f.id]}
    @auditorias = Auditoriacadastro.find(:all, :conditions=>["usuario_id=?", @usuario.id], :order=>"created_at desc")
    render :update do |page|
      page.visual_effect(:highlight , "auditorias")
      page.replace_html "auditorias", render(:partial=>"index")
    end
  end

  def new
    @usuario = Usuario.find(params[:adminusuario_id])
    @auditorias = Auditoriacadastro.find(:all, :conditions=>["usuario_id=?", @usuario.id], :order=>"created_at desc")
    if params[:filtro_formulario]
      @auditorias.collect! {|a| a if a.formulario_id == params[:formulario_id].to_i}.compact!
    end
    if params[:filtro_acao]
      @auditorias.collect! {|a| a if a.acao == params[:acao]}.compact!
    end
    if params[:filtro_periodo]
      di = "#{params[:post]['d_i(1i)']}-#{params[:post]['d_i(2i)']}-#{params[:post]['d_i(3i)']}".to_date
      df = "#{params[:post]['d_f(1i)']}-#{params[:post]['d_f(2i)']}-#{params[:post]['d_f(3i)']}".to_date
      @auditorias.collect! {|a| a if a.created_at.to_date >= di and a.created_at.to_date <= df}.compact!
    end
    render :update do |page|
      page.visual_effect(:highlight , 'exibir_auditorias')
      page.replace_html "exibir_auditorias", render(:partial => "new")
    end
  end

  def clean
    render :update do |page|
      page.visual_effect(:highlight , "auditorias")
      page.replace_html "auditorias", render(:text=>"")
    end
  end
end

