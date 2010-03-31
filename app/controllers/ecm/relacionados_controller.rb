class Ecm::RelacionadosController < ApplicationController
  skip_before_filter :autorizado

  def index
    @cadastro = Cadastro.find(params[:cadastro_id])
    @form_rel = []
    Itensformulario.da_entidade(@sessao_usuario.entidade_id).do_tipo("referencia").find(:all).each do |i|
      if i.opcoes[0][:referenciado] == @cadastro.formulario_id.to_s and i.formulario.permissao(@sessao_usuario.usuario) > 0
        @form_rel << [i.formulario.titulo, i.formulario_id]
      end
    end
    @form_rel.compact.uniq
    render :update do |page|
      page.visual_effect(:highlight , "relacionados")
      page.replace_html "relacionados", render(:partial=>"index")
    end
  end

  def new
    @cadastro = Cadastro.find(params[:cadastro_id])
    @formulario = Formulario.find(params[:formulario_id])
    @principal = Itensformulario.find(@formulario.principal_id)
    @cads = []
    @res = []
    @formulario.itensformularios.each do |form_item|
      if form_item.tipo == "referencia"
        if form_item.opcoes[0][:referenciado] == @cadastro.formulario_id.to_s
          filtro = eval("#{form_item.itenstipo.componente.camelize}EcmBase.new")
          @cads << filtro.busca_avancada(form_item, nil, @cadastro.id)
          if @cads.size > 0
            @res = @cads[0]
            @cads.each do |c|
              @res = @res & c
            end
          end
        end
      end
    end
    @cadastro_itens = EcmItemTexto.do_formulario(@formulario.id).do_itens_formulario(@formulario.principal_id).find(:all, :conditions=>["cadastro_id in (?)", @res])
    @tipo = params[:tipo]
    render :update do |page|
      page.visual_effect(:highlight , 'exibir_relacionados')
      page.replace_html "exibir_relacionados", render(:partial => "new")
    end
  end

  def clean
    render :update do |page|
      page.visual_effect(:highlight , "relacionados")
      page.replace_html "relacionados", render(:text=>"")
    end
  end
end

