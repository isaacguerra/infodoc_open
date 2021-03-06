module TextoLongoEcmHelper
#================================================================
# helper para criação do item do formulario

  def texto_longo_ecm_new_form_item
    view = ""
     view.concat("<table>")
      view.concat("<tr>")
        view.concat("<td class='lista_item'/>")
        view.concat("<td class='lista_conteudo'>")
     view.concat("<h3>Item Texto Longo</h3>")
     view.concat("<p> Este item receberá textos longos (grades).</p>")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td class='lista_item'>")
          view.concat("Largura do Campo:<br/>")
        view.concat("</td>")
        view.concat("<td class='lista_conteudo'>")            
          view.concat(text_field "opcoes", :largura)
          view.concat("<p>Informe a largura da caixa de texto</p>")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td class='lista_item'>")
          view.concat("Altura do Campo:")
        view.concat("</td>")
        view.concat("<td class='lista_conteudo'>")    
          view.concat(text_field "opcoes", :altura)
          view.concat("<p>Informe a largura da caixa de texto</p>")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td class='lista_item'>")
          view.concat("Aceita valor Vazio?:")
        view.concat("</td>")
        view.concat("<td class='lista_conteudo'>")
          view.concat(select "opcoes", :nulo, [["Ativo", 1], ["Inativo", 0]])
          view.concat("<p>Informe o campo poderá ser Nulo(vazio)!</p>")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td class='lista_item'/>")
        view.concat("<td class='lista_conteudo'>")
          view.concat(submit_tag("Salvar Item"))
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("</table>")
     view.concat("</table>")
  end
#-------------------------------------------------------------------------------

#===============================================================================
# Helper para edição do item no formulario

  def texto_longo_ecm_edit_form_item(form_item)
    view = ""
      view.concat("<table>")
      view.concat("<tr>")
        view.concat("<td class='lista_item'/>")
        view.concat("<td class='lista_conteudo'>")
     view.concat("<h3>Item Texto Longo</h3>")
     view.concat("<p> Este item receberá textos longos (grades).</p>")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td class='lista_item'>")
          view.concat("Largura do Campo:")
        view.concat("</td>")
        view.concat("<td class='lista_conteudo'>")    
          view.concat(text_field "opcoes", :largura)
          view.concat("<p>Informe a largura da caixa de texto</p>")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td class='lista_item'>")
          view.concat("Altura do Campo:")
        view.concat("</td>")
        view.concat("<td class='lista_conteudo'>")    
          view.concat(text_field "opcoes", :altura)
          view.concat("<p>Informe a largura da caixa de texto</p>")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td class='lista_item'>")
          view.concat("Aceita valor Vazio?:")
        view.concat("</td>")
        view.concat("<td class='lista_conteudo'>")  
          view.concat(select "opcoes", :nulo, [["Ativo", 1], ["Inativo", 0]], :selected=>form_item.opcoes[:nulo].to_i)
          view.concat("<p>Informe o campo poderá ser Nulo(vazio)!</p>")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td class='lista_item'/>")
        view.concat("<td class='lista_conteudo'>")
          view.concat(submit_tag("Salvar Item"))
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("</table>")
     view.concat("</table>")
  end
#-------------------------------------------------------------------------------
# Helper para exibição do item no formulario
  def texto_longo_ecm_show_form_item(form_item)
    view = ""
    view.concat("<tr>")
      view.concat("<td class='lista_item'>")
        view.concat("Largura")
      view.concat("</td>")
      view.concat("<td class='lista_conteudo'>")
        view.concat(form_item.opcoes[:largura])
      view.concat("</td>")
    view.concat("</tr>")
    view.concat("<tr>")
      view.concat("<td class='lista_item'>")
        view.concat("Altura")
      view.concat("</td>")
      view.concat("<td class='lista_conteudo'>")
        view.concat(form_item.opcoes[:altura])
      view.concat("</td>")
    view.concat("</tr>")
    view.concat("<tr>")
      view.concat("<td class='lista_item'>")
        view.concat("Nulo:<br/>")
      view.concat("</td>")
      view.concat("<td class='lista_conteudo'>")
        view.concat(status(form_item.opcoes[:nulo]))
      view.concat("</td>")
    view.concat("</tr>")
  end

#===============================================================================
# helper de cadastro

  def texto_longo_ecm_new_cadastro_item(form_item, params)
    view = ""
    unless params
      view.concat(text_area :cadastro, "item_#{form_item.id}", options={:cols=>form_item.opcoes[:largura], :rows=>form_item.opcoes[:altura]})
    else
      view.concat(text_area :cadastro, "item_#{form_item.id}", options={:value=>params["item_#{form_item.id}"], :cols=>form_item.opcoes[:largura], :rows=>form_item.opcoes[:altura]})
    end
    return view
  end

  def texto_longo_ecm_edit_cadastro_item(form_item, cadastro, params)
    base = TextoLongoEcmBase.new
    cadastro_item = base.busca_cadastro_item(form_item, cadastro)
    view = ""
     view.concat(text_area :cadastro, "item_#{form_item.id}" ,options={:value=>cadastro_item.conteudo, :cols=>form_item.opcoes[:largura], :rows=>form_item.opcoes[:altura]})
     return view
  end

  def texto_longo_ecm_find_cadastro_item(form_item)
    view = ""
    view.concat(text_field :cadastro, "item_#{form_item.id}", options={:size=>40})
    return view
  end

  def texto_longo_ecm_show_cadastro_item(form_item, cadastro)
    base = TextoLongoEcmBase.new
    cadastro_item = base.busca_cadastro_item(form_item, cadastro)
    return "#{cadastro_item.conteudo}"
  end

  def texto_longo_ecm_show_filtro_cadastro_item(form_item, cadastro)
    base = TextoLongoEcmBase.new
    cadastro_item = base.busca_cadastro_item(form_item, cadastro)
    return "#{cadastro_item.conteudo}"
  end

  def texto_longo_ajax
  end

end

