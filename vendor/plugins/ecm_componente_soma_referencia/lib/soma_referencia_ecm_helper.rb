module SomaReferenciaEcmHelper
#================================================================
# helper para criação do item do formulario

  def soma_referencia_ecm_new_form_item

    #form_rel = Itensformulario.da_entidade(@sessao_usuario.entidade_id).do_tipo("referencia").find(:all).collect {|i| [i.formulario.titulo, i.formulario_id] if i.opcoes[0][:referenciado] == @cadastro.formulario_id.to_s}.compact.uniq

    view = ""
     view.concat("Item Referecia a outro Formulário")
     view.concat("<li>Este Item fará referencia a outros formulários</li>")
     view.concat("<table>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat(select "opcoes", :referenciado, Formulario.do_tipo(1).ativo.da_entidade(@sessao_usuario.entidade_id).find(:all).collect {|f| ["#{f.formulariocategoria.nome} - #{f.titulo}", f.id]}, :prompt=>" -- ")
          view.concat("<li>Escolha o Formulário a ser Referenciado</li>")
          view.concat(observe_field "opcoes_referenciado", :frequency => 1, :url => {:action => "ajax", :id=>@itenstipo.id}, :with => "'referenciado='+escape(value)")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<table>")
      view.concat("<tr>")
        view.concat("<td>")
         view.concat("<span id='ajax_item'></span>")
        view.concat("</td>")
      view.concat("</tr>")
  end
#-------------------------------------------------------------------------------

#===============================================================================
# Helper para edição do item no formulario

  def soma_referencia_ecm_edit_form_item(form_item)
    view = ""
     view.concat("Item Referecia a outro Formulário")
     view.concat("<li>Este Item fará referencia a outros formulários</li>")
     view.concat("<table>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat(select "opcoes", :referenciado, Formulario.do_tipo(1).ativo.da_entidade(@sessao_usuario.entidade_id).find(:all, :select=>"id, titulo").collect {|f| [f.titulo, f.id]}, :selected=>form_item.opcoes[0][:referenciado].to_i)
          view.concat("<li>Escolha o Formulário a ser Referenciado</li>")
          view.concat(observe_field "opcoes_referenciado", :frequency => 1, :url => {:action => "ajax", :id=>form_item.itenstipo.id}, :with => "'referenciado='+escape(value)")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<table>")
      view.concat("<tr>")
        view.concat("<td>")
         view.concat("<span id='ajax_item'>")
          view.concat(soma_referencia_ecm_form_item_ajax(nil, nil, form_item.opcoes[0][:referenciado]))
         view.concat("</span>")
        view.concat("</td>")
      view.concat("</tr>")
  end
#-------------------------------------------------------------------------------

  def soma_referencia_ecm_show_form_item(form_item)
    formulario = Formulario.find(form_item.opcoes[0][:referenciado])
    view = ""
    view.concat("<tr>")
      view.concat("<td class='lista_item'>")
        view.concat("Referenciado")
      view.concat("</td>")
      view.concat("<td class='lista_conteudo'>")
        view.concat(formulario.titulo)
      view.concat("</td>")
    view.concat("</tr>")
    view.concat("<tr>")
      view.concat("<td class='lista_item'>")
        view.concat("Filtro")
      view.concat("</td>")
      view.concat("<td class='lista_conteudo'>")
        formulario.itensformularios.each do |item|
          if form_item[:opcoes][1]["check_#{item.id}"] == "1"
             view.concat(item.rotulo)
             view.concat(" : ")
             view.concat(form_item[:opcoes][2]["item_#{item.id}"])
          end
        end
      view.concat("</td>")
    view.concat("</tr>")
  end

  def soma_referencia_ecm_form_item_ajax(form_item, params, valor=nil)
    view = "<table>"
    view.concat("<tr><th>Filtrar pelos Itens</th></tr>")
    unless valor
      formulario = Formulario.find(params[:referenciado])
    else
      formulario = Formulario.find(valor)
    end

    campos_soma = []

    formulario.itensformularios.each do |form_item|
      view.concat("<tr>")
      view.concat("<td>")
      view.concat(form_item.rotulo)
      view.concat("</td>")
      view.concat("<td>")
      view.concat(ecm_find_cadastro_item(form_item))
      view.concat("</td>")
      view.concat("<td>")
      view.concat(check_box(:filtro, "check_#{form_item.id}"))
      view.concat("</td>")
      view.concat("</tr>")

      if form_item.tipo == "valor_monetario"
        campos_soma << [form_item.rotulo, form_item.id]
      end
    end
    if campos_soma.size > 0
      view.concat("</table>")
      view.concat("<table>")
      view.concat("<tr>")
       view.concat("<td>Lista de Campos Somáveis</td>")
      view.concat("</tr>")
      view.concat("<tr>")
       view.concat("<td>")
         view.concat("Somar os Valores do Campo: ")
         view.concat(select :soma, "somado", campos_soma)
       view.concat("</td>")
      view.concat("</tr>")
      view.concat("</table>")
      view.concat("<tr>")
          view.concat("<td>")
            view.concat(submit_tag("Salvar Item"))
          view.concat("</td>")
        view.concat("</tr>")
        view.concat("</table>")
       view.concat("</table>")
    end
    return view
  end

#===============================================================================
# helper de cadastro

  def soma_referencia_ecm_new_cadastro_item(form_item, params)
    view = ""
    return view
  end

  def soma_referencia_ecm_edit_cadastro_item(form_item, cadastro_item, params)
    view = ""
    return view
  end

  def soma_referencia_ecm_find_cadastro_item(form_item)
    view = ""
    return view
  end


  def soma_referencia_ecm_show_cadastro_item(form_item, cadastro)
    view = ""
    formulario = Formulario.find(form_item.opcoes[0][:referenciado])
    somado = Itensformulario.find(form_item.opcoes[3][:somado])
    tenho_referencia = false
    iref = ""

    formulario.itensformularios.each do |item|
      if item.tipo == "referencia"
        if item.opcoes[0][:referenciado].to_i == form_item.formulario_id
          tenho_referencia = true
          iref = item.id
        end
      end
    end

    cads = []

    unless tenho_referencia
      res = []
    else
       res = EcmItemReferencia.find(:all, :conditions=>["itensformulario_id = ? and referencia_id = ?", iref, cadastro.id]).collect {|c| c.cadastro_id}
    end

    tudo = true
    formulario.itensformularios.each do |item|
      if form_item[:opcoes][1]["check_#{item.id}"] == "1"
        tudo = false
        filtro = eval("#{item.itenstipo.componente.camelize}EcmBase.new")
        cads << filtro.busca_avancada(item, nil, form_item[:opcoes][2]["item_#{item.id}"])
        if cads.size > 0
          res = cads[0] unless tenho_referencia
          cads.each do |c|
            res = res & c
          end
        end
      end
    end
    total = 0
    if tudo == false or tenho_referencia == true
      total = EcmItemNumeroDecimal.do_formulario(formulario.id).do_itens_formulario(somado.id).sum('conteudo', :conditions=>["cadastro_id in (?)", res])
    else
      total = EcmItemNumeroDecimal.do_formulario(formulario.id).do_itens_formulario(somado.id).sum('conteudo')
    end
    return sprintf("%.2f", total)
  end

  def soma_referencia_ecm_show_filtro_cadastro_item(form_item, cadastro)
    soma_referencia_ecm_show_cadastro_item(form_item, cadastro)
#    view = ""
#    formulario = Formulario.find(form_item.opcoes[0][:referenciado])
#    somado = Itensformulario.find(form_item.opcoes[3][:somado])
#    cads = []
#    res = []
#    tudo = true
#    formulario.itensformularios.each do |item|
#      if form_item[:opcoes][1]["check_#{item.id}"] == "1"
#        tudo = false
#        filtro = eval("#{item.itenstipo.componente.camelize}EcmBase.new")
#        cads << filtro.busca_avancada(item, nil, form_item[:opcoes][2]["item_#{item.id}"])
#        if cads.size > 0
#          res = cads[0]
#          cads.each do |c|
#            res = res & c
#          end
#        end
#      end
#    end
#    unless tudo
#      total = EcmItemNumeroDecimal.do_formulario(formulario.id).do_itens_formulario(somado.id).sum('conteudo', :conditions=>["cadastro_id in (?)", res])
#    else
#      total = EcmItemNumeroDecimal.do_formulario(formulario.id).do_itens_formulario(somado.id).sum('conteudo')
#    end
#    return total
  end
end

