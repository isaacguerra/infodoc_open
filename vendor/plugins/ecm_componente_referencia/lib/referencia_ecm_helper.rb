module ReferenciaEcmHelper
#================================================================
# helper para criação do item do formulario

  def referencia_ecm_new_form_item
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
      view.concat("<tr>")
        view.concat("<td>")
          view.concat(submit_tag("Salvar Item"))
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("</table>")
     view.concat("</table>")
  end
#-------------------------------------------------------------------------------

#===============================================================================
# Helper para edição do item no formulario

  def referencia_ecm_edit_form_item(form_item)
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
          view.concat(referencia_ecm_form_item_ajax(nil, nil, form_item.opcoes[0][:referenciado]))
         view.concat("</span>")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat(submit_tag("Salvar Item"))
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("</table>")
     view.concat("</table>")
  end
#-------------------------------------------------------------------------------

  def referencia_ecm_show_form_item(form_item)
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

  def referencia_ecm_form_item_ajax(form_item, params, valor=nil)
    view = "<table>"
    view.concat("<tr><th>Filtrar pelos Itens</th></tr>")
    unless valor
      formulario = Formulario.find(params[:referenciado])
    else
      formulario = Formulario.find(valor)
    end

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
    end
    view.concat("</table>")
    return view
  end

#===============================================================================
# helper de cadastro

  def referencia_ecm_new_cadastro_item(form_item, params)
    view = ""
    formulario = Formulario.find(form_item.opcoes[0][:referenciado])
    principal = Itensformulario.find(formulario.principal_id)
    cads = []
    res = []
    tudo = true
    formulario.itensformularios.each do |item|
      if form_item[:opcoes][1]["check_#{item.id}"] == "1"
        tudo = false
        filtro = eval("#{item.itenstipo.componente.camelize}EcmBase.new")
        cads << filtro.busca_avancada(item, nil, form_item[:opcoes][2]["item_#{item.id}"])
        if cads.size > 0
          res = cads[0]
          cads.each do |c|
            res = res & c
          end
        end
      end
    end
    unless tudo
      cadastro_itens = EcmItemTexto.do_formulario(formulario.id).do_itens_formulario(formulario.principal_id).find(:all, :select=>"cadastro_id, conteudo", :conditions=>["cadastro_id in (?)", res]).collect {|i| [i.conteudo, i.cadastro_id]}
    else
      cadastro_itens = EcmItemTexto.do_formulario(formulario.id).do_itens_formulario(formulario.principal_id).find(:all, :select=>"cadastro_id, conteudo").collect {|i| [i.conteudo, i.cadastro_id]}
    end
    view.concat(link_to "+", new_ecm_formulario_cadastro_path(formulario)) if formulario.permissao(@sessao_usuario.usuario) > 1
    unless params
      view.concat(select :cadastro, "item_#{form_item.id}", cadastro_itens)
    else
      if params[:cadastro]
        if params[:cadastro]["item_#{form_item.id}"]
          view.concat(select :cadastro, "item_#{form_item.id}", cadastro_itens, :selected=>params[:cadastro]["item_#{form_item.id}"].to_i)
        else
          view.concat(select :cadastro, "item_#{form_item.id}", cadastro_itens)
        end
      else
        view.concat(select :cadastro, "item_#{form_item.id}", cadastro_itens)
      end
    end
    return view
  end

  def referencia_ecm_edit_cadastro_item(form_item, cadastro, params)
    base = ReferenciaEcmBase.new
    cadastro_item = base.busca_cadastro_item(form_item, cadastro)
    view = ""
    formulario = Formulario.find(form_item.opcoes[0][:referenciado])
    principal = Itensformulario.find(formulario.principal_id)
    cads = []
    res = []
    tudo = true
    formulario.itensformularios.each do |item|
      if form_item[:opcoes][1]["check_#{item.id}"] == "1"
        tudo = false
        filtro = eval("#{item.itenstipo.componente.camelize}EcmBase.new")
        cads << filtro.busca_avancada(item, nil, form_item[:opcoes][2]["item_#{item.id}"])
        if cads.size > 0
          res = cads[0]
          cads.each do |c|
            res = res & c
          end
        end
      end
    end
    unless tudo
      cadastro_itens = EcmItemTexto.do_formulario(formulario.id).do_itens_formulario(formulario.principal_id).find(:all, :select=>"cadastro_id, conteudo", :conditions=>["cadastro_id in (?)", res]).collect {|i| [i.conteudo, i.cadastro_id]}
    else
      cadastro_itens = EcmItemTexto.do_formulario(formulario.id).do_itens_formulario(formulario.principal_id).find(:all, :select=>"cadastro_id, conteudo").collect {|i| [i.conteudo, i.cadastro_id]}
    end

    view.concat(link_to "+", new_ecm_formulario_cadastro_path(formulario)) if formulario.permissao(@sessao_usuario.usuario) > 1
    unless params
      view.concat(select :cadastro, "item_#{form_item.id}", cadastro_itens, :selected=>cadastro_item.referencia_id.to_i)
    else
     view.concat(select :cadastro, "item_#{form_item.id}", cadastro_itens, :selected=>params[:cadastro]["item_#{form_item.id}"].to_i)
    end
    return view
  end

  def referencia_ecm_find_cadastro_item(form_item)
    view = ""
    formulario = Formulario.find(form_item.opcoes[0][:referenciado])
    principal = Itensformulario.find(formulario.principal_id)
    cads = []
    res = []
    tudo = true
    formulario.itensformularios.each do |item|
      if form_item[:opcoes][1]["check_#{item.id}"] == "1"
        tudo = false
        filtro = eval("#{item.itenstipo.componente.camelize}EcmBase.new")
        cads << filtro.busca_avancada(item, nil, form_item[:opcoes][2]["item_#{item.id}"])
        if cads.size > 0
          res = cads[0]
          cads.each do |c|
            res = res & c
          end
        end
      end
    end
    unless tudo
      cadastro_itens = EcmItemTexto.do_formulario(formulario.id).do_itens_formulario(formulario.principal_id).find(:all, :select=>"cadastro_id, conteudo", :conditions=>["cadastro_id in (?)", res]).collect {|i| [i.conteudo, i.cadastro_id]}
    else
      cadastro_itens = EcmItemTexto.do_formulario(formulario.id).do_itens_formulario(formulario.principal_id).find(:all, :select=>"cadastro_id, conteudo").collect {|i| [i.conteudo, i.cadastro_id]}
    end
    view.concat(select :cadastro, "item_#{form_item.id}", cadastro_itens)
    return view
  end


  def referencia_ecm_show_cadastro_item(form_item, cadastro)
    base = ReferenciaEcmBase.new
    cadastro_item = base.busca_cadastro_item(form_item, cadastro)
    cadastro = Cadastro.find(cadastro_item.referencia_id)
    if cadastro.formulario.permissao(@sessao_usuario.usuario) > 0
      return link_to EcmItemTexto.do_cadastro(cadastro.id).do_itens_formulario(cadastro.formulario.principal_id).find(:first).conteudo, ecm_formulario_cadastro_path(cadastro.formulario, cadastro)
    else
      EcmItemTexto.do_cadastro(cadastro.id).do_itens_formulario(cadastro.formulario.principal_id).find(:first).conteudo
    end
  end

  def referencia_ecm_show_filtro_cadastro_item(form_item, cadastro)
    base = ReferenciaEcmBase.new
    cadastro_item = base.busca_cadastro_item(form_item, cadastro)
    cadastro = Cadastro.find(cadastro_item.referencia_id)
    if cadastro.formulario.permissao(@sessao_usuario.usuario) > 0
      return link_to EcmItemTexto.do_cadastro(cadastro.id).do_itens_formulario(cadastro.formulario.principal_id).find(:first).conteudo, ecm_formulario_cadastro_path(cadastro.formulario, cadastro)
    else
      EcmItemTexto.do_cadastro(cadastro.id).do_itens_formulario(cadastro.formulario.principal_id).find(:first).conteudo
    end
  end

end

