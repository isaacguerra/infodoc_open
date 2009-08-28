module AutoNumeracaoEcmHelper
#================================================================
# helper para criação do item do formulario

  def auto_numeracao_ecm_new_form_item
    view = ""
     view.concat("Item Texto")
     view.concat("<li> Este item criará um campo auto numeado.</li>")
     view.concat("<table>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Valor Inicial:<br/>")
          view.concat(text_field "opcoes", :valor, :value=>"0")
          view.concat("<li>Informe o numero de início da contagem</li>")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Prefixo:<br/>")
          view.concat(text_field "opcoes", :prefixo)
          view.concat("<li>Informe o texto antes do numero</li>")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Pósfixo:<br/>")
          view.concat(text_field "opcoes", :posfixo)
          view.concat("<li>Informe o texto após do numero</li>")
        view.concat("</td>")
      view.concat("</tr>")
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

  def auto_numeracao_ecm_edit_form_item(form_item)
    view = ""
     view.concat("Item Texto")
     view.concat("<li> Este item criará um campo auto numeado.</li>")
     view.concat("<table>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Valor Inicial:<br/>")
          view.concat(text_field "opcoes", :valor, :value=>form_item.opcoes[:valor])
          view.concat("<li>Informe o numero de início da contagem</li>")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Prefixo:<br/>")
          view.concat(text_field "opcoes", :prefixo, :value=>form_item.opcoes[:prefixo])
          view.concat("<li>Informe o texto antes do numero</li>")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Pósfixo:<br/>")
          view.concat(text_field "opcoes", :posfixo, :value=>form_item.opcoes[:posfixo])
          view.concat("<li>Informe o texto após do numero</li>")
        view.concat("</td>")
      view.concat("</tr>")
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

  def auto_numeracao_ecm_show_form_item(form_item)
    view = ""
    view.concat("<tr>")
      view.concat("<td class='lista_item'>")
        view.concat("Valor")
      view.concat("</td>")
      view.concat("<td class='lista_conteudo'>")
        view.concat(form_item.opcoes[:valor])
      view.concat("</td>")
    view.concat("</tr>")
    view.concat("<tr>")
      view.concat("<td class='lista_item'>")
        view.concat("Prefixo:<br/>")
      view.concat("</td>")
      view.concat("<td class='lista_conteudo'>")
        view.concat(form_item.opcoes[:prefixo])
      view.concat("</td>")
    view.concat("</tr>")
    view.concat("<tr>")
      view.concat("<td class='lista_item'>")
        view.concat("Pósfixo:<br/>")
      view.concat("</td>")
      view.concat("<td class='lista_conteudo'>")
        view.concat(form_item.opcoes[:posfixo])
      view.concat("</td>")
    view.concat("</tr>")
  end

#===============================================================================
# helper de cadastro

  def auto_numeracao_ecm_new_cadastro_item(form_item, params)
    view = ""
    unless params
     form_item.opcoes[:valor] = (form_item.opcoes[:valor].to_i + 1).to_s
     form_item.save
     num = "#{form_item.opcoes[:prefixo]}#{form_item.opcoes[:valor]}#{form_item.opcoes[:posfixo]}"
     view.concat(text_field :cadastro, "item_#{form_item.id}", :value=>num, :readonly=>true)
    else
     view.concat(text_field :cadastro, "item_#{form_item.id}", options={:value=>params["item_#{form_item.id}"], :readonly=>true})
    end
    return view
  end

  def auto_numeracao_ecm_edit_cadastro_item(form_item, cadastro_item, params)
    view = ""
    view.concat(text_field :cadastro, "item_#{form_item.id}", options={:value=>cadastro_item.conteudo, :readonly=>true})
    return view
  end

  def auto_numeracao_ecm_find_cadastro_item(form_item)
    view = ""
    view.concat(text_field :cadastro, "item_#{form_item.id}")
    return view
  end


  def auto_numeracao_ecm_show_cadastro_item(form_item, cadastro_item)
    return cadastro_item.conteudo
  end

  def auto_numeracao_ecm_show_filtro_cadastro_item(form_item, cadastro_item)
    return cadastro_item.conteudo
  end


  def texto_ajax
  end
end

