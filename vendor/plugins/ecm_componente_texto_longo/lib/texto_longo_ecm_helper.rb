module TextoLongoEcmHelper
#================================================================
# helper para criação do item do formulario

  def texto_longo_ecm_new_form_item
    view = ""
     view.concat("Item Texto Longo")
     view.concat("<li> Este item receberá textos longos (grades).</li>")
     view.concat("<table>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Largura do Campo:<br/>")
          view.concat(text_field "opcoes", :largura)
          view.concat("<li>Informe a largura da caixa de texto</li>")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Altura do Campo:<br/>")
          view.concat(text_field "opcoes", :altura)
          view.concat("<li>Informe a largura da caixa de texto</li>")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Aceita valor Vazio?:")
          view.concat(select "opcoes", :nulo, [["Ativo", 1], ["Inativo", 0]])
          view.concat("<li>Informe o campo poderá ser Nulo(vazio)!</li>")
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

  def texto_longo_ecm_edit_form_item(form_item)
    view = ""
     view.concat("Item Texto Longo")
     view.concat("<li> Este item receberá textos longos (grades).</li>")
     view.concat("<table>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Largura do Campo:<br/>")
          view.concat(text_field "opcoes", :largura)
          view.concat("<li>Informe a largura da caixa de texto</li>")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Altura do Campo:<br/>")
          view.concat(text_field "opcoes", :altura)
          view.concat("<li>Informe a largura da caixa de texto</li>")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Aceita valor Vazio?:")
          view.concat(select "opcoes", :nulo, [["Ativo", 1], ["Inativo", 0]], :selected=>form_item.opcoes[:nulo].to_i)
          view.concat("<li>Informe o campo poderá ser Nulo(vazio)!</li>")
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

  def texto_longo_ecm_edit_cadastro_item(form_item, cadastro_item, params)
    view = ""
     view.concat(text_area :cadastro, "item_#{form_item.id}" ,options={:value=>cadastro_item.conteudo, :cols=>form_item.opcoes[:largura], :rows=>form_item.opcoes[:altura]})
     return view
  end


  def texto_longo_ecm_show_cadastro_item(form_item, cadastro_item)
    return "<pre>#{cadastro_item.conteudo}</pre>"
  end

  def texto_longo_ajax
  end
end

