class Ecm::AuditoriaproducaosController < ApplicationController
  def index
  end

  def show
    if params[:id] == "artefato"
      render :update do |page|
        page.visual_effect(:highlight , "filtro")
        page.replace_html "filtro", render(:partial=>"artefato")
      end
    elsif params[:id] == "relacionados"
      render :update do |page|
        page.visual_effect(:highlight , "filtro")
        page.replace_html "filtro", render(:partial=>"relacionado")
      end
    elsif params[:id] == "dados"
      render :update do |page|
        page.visual_effect(:highlight , "filtro")
        page.replace_html "filtro", render(:partial=>"dados")
      end
    else
      render :update do |page|
        page.visual_effect(:highlight , "filtro")
        page.replace_html "filtro", render(:partial=>"extrato")
      end
    end

  end

  def create
    if params[:tipo]=="artefato"
      @formulario = Formulario.find(params[:formulario])
      @principal = Itensformulario.find(@formulario.principal_id)

      quant = params[:quant].to_i
      @cadastros = Cadastro.do_formulario(params[:formulario]).find(:all)
      @cadastros.collect! {|c| c if c.children.size != quant}
      @cadastros.compact!

      render :update do |page|
        page.visual_effect(:highlight , "resultado")
        page.replace_html "resultado", render(:partial=>"resultartefato")
      end
    elsif params[:tipo]=="relacionados"
      @form_pai = Formulario.find(params[:formulario_pai])
      @form_filho = Formulario.find(params[:formulario_filho])

      @principal = Itensformulario.find(@form_pai.principal_id)

      if_ff = Itensformulario.find(:all, :conditions=>["formulario_id=? and tipo='referencia'", @form_filho.id])

      id_iff = nil

      if if_ff.size > 0
         if_ff.each do |iff|
            id_iff = iff.id if iff.tipo=="referencia" and iff.opcoes[0][:referenciado].to_i==@form_pai.id
         end
      end

      if id_iff
        cads_pai = Cadastro.do_formulario(@form_pai.id).find(:all)
        @errados = []
        @errados_q = []
        cads_pai.each do |c|
          tem = EcmItemReferencia.do_formulario(@form_filho.id).do_itens_formulario(id_iff).count(:id, :conditions=>["referencia_id=?",c.id])
          unless tem == 1
            @errados << c
            @errados_q << tem
          end
        end
        render :update do |page|
          page.visual_effect(:highlight , "resultado")
          page.replace_html "resultado", render(:partial=>"resultrelacionado")
        end
      else
        render :update do |page|
          page.visual_effect(:highlight , "resultado")
          page.replace_html "resultado", render(:text=>"Formularios não Relacionados")
        end
      end
    elsif params[:tipo]=="dados"
      @formulario = Formulario.find(params[:formulario])
      @principal = Itensformulario.find(@formulario.principal_id)

      @cadastros = Cadastro.do_formulario(params[:formulario]).find(:all, :conditions=>["auditado=?", false], :order=>"created_at desc")

      render :update do |page|
        page.visual_effect(:highlight , "resultado")
        page.replace_html "resultado", render(:partial=>"resultdados")
      end

    else
      @di = "#{params[:periodo]["data_inicio(1i)"]}-#{params[:periodo]["data_inicio(2i)"]}-#{params[:periodo]["data_inicio(3i)"]}".to_date
      @df = "#{params[:periodo]["data_fim(1i)"]}-#{params[:periodo]["data_fim(2i)"]}-#{params[:periodo]["data_fim(3i)"]}".to_date

      @usuario = Usuario.find(params[:usuario_id])
      @producao = Auditoriacadastro.find(:all, :conditions=>["usuario_id=?", params[:usuario_id]])
      @producao.collect! {|a| a if a.created_at.to_date >= @di and a.created_at.to_date <= @df}.compact!

      @cadastros_criados = 0
      @cadastros_auditados = 0
      @cadastros_alterados = 0
      @cadastros_excluidos = 0
      @artefatos_criados = 0
      @artefatos_excuidos = 0

      cadastros_auditados = Cadastro.auditado.find(:all, :select=>"id, created_at")
      cadastros_auditados.collect! {|a| a if a.created_at.to_date >= @di and a.created_at.to_date <= @df}.compact!

      @auditados = Cadastro.auditado.find(:all, :conditions=>["auditor_id=?", params[:usuario_id]], :select=>"id, created_at")
      @auditados.collect! {|a| a if a.created_at.to_date >= @di and a.created_at.to_date <= @df}.compact!

      @total_cadastros_auditados = 0

      @producao.each do |prod|
        if prod.acao == "create"
          @cadastros_criados += 1
          cadastros_auditados.each {|ca| @cadastros_auditados +=1 if prod.cadastro_id == ca.id }
        elsif prod.acao == "update"
          @cadastros_alterados += 1
        elsif prod.acao == "destroy"
          @cadastros_excuidos += 1
        elsif prod.acao == "create_artefato"
          @artefatos_criados += 1
        elsif prod.acao == "destroy_artefato"
          @artefatos_excluidos += 1
        end
      end

      render :update do |page|
        page.visual_effect(:highlight , "resultado")
        page.replace_html "resultado", render(:partial=>"resultextrato")
      end

    end
  end


  def update
    @cadastro = Cadastro.find(params[:id])
    @formulario = Formulario.find(@cadastro.formulario_id)
    @principal = Itensformulario.find(@formulario.principal_id)
    @cadastro.auditado = true
    @cadastro.auditor_id = @sessao_usuario.usuario_id
    @cadastro.auditado_at = DateTime.now
    @cadastro.save

    render :update do |page|
      page.visual_effect(:highlight , "audi_#{params[:id]}")
      page.replace_html "audi_#{params[:id]}", render(:text=>"auditado")
    end
  end


end

