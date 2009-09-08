module IdentificadorUnicoEcmHelper
#================================================================
# helper para criação do item do formulario

  def identificador_unico_ecm_new_form_item
    view = ""
     view.concat("Item Texto")
     view.concat("<li>Este item criará um campo Único e Aleatorório</li>")
     view.concat("<table>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Informe o tamanho do Identificador(não deve ser superior a 255 caracteres):<br/>")
          view.concat(text_field "opcoes", :tamanho, :value=>"10")
          view.concat("<li>Informe o tamanho do Identificador</li>")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Informe o Tipo de Chave:")
          view.concat(select "opcoes", :tipo, [["Numerico", 1], ["Alphanumerico", 2], ["Alphanumerico com Caracteres Especiais", 3]])
          view.concat("<li>Informe o tipo de Chave!</li>")
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

  def identificador_unico_ecm_edit_form_item(form_item)
    view = ""
     view.concat("Item Texto")
     view.concat("<li>Este item criará um campo Único e Aleatorório</li>")
     view.concat("<table>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Informe o tamanho do Identificador(não deve ser superior a 255 caracteres):<br/>")
          view.concat(text_field "opcoes", :tamanho, :value=>form_item.opcoes[:tamanho])
          view.concat("<li>Informe o tamanho do Identificador</li>")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Informe o Tipo de Chave:")
          view.concat(select "opcoes", :tipo, [["Numerico", 1], ["Alphanumerico", 2], ["Alphanumerico com Caracteres Especiais", 3]], :selected=>form_item.opcoes[:tipo].to_i)
          view.concat("<li>Informe o tipo de Chave!</li>")
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

  def identificador_unico_ecm_show_form_item(form_item)
    view = ""
    view.concat("<tr>")
      view.concat("<td class='lista_item'>")
        view.concat("Tamanho")
      view.concat("</td>")
      view.concat("<td class='lista_conteudo'>")
        view.concat(form_item.opcoes[:tamanho])
      view.concat("</td>")
    view.concat("</tr>")
    view.concat("<tr>")
      view.concat("<td class='lista_item'>")
        view.concat("Tipo:<br/>")
      view.concat("</td>")
      view.concat("<td class='lista_conteudo'>")
        view.concat(form_item.opcoes[:tipo])
      view.concat("</td>")
    view.concat("</tr>")
  end

#===============================================================================
# helper de cadastro

  def identificador_unico_ecm_new_cadastro_item(form_item, params)
    view = ""
    unless params
     if form_item.opcoes[:tipo] == "1"
      chars = (0..9).to_a
     elsif form_item.opcoes[:tipo] == "2"
      chars = ('A'..'Z').to_a + (0..9).to_a
     else
      chars = ('A'..'Z').to_a + (0..9).to_a + ['!','@','#','$','%','&','*']
     end
     chave = (0...form_item.opcoes[:tamanho].to_i).collect { chars[Kernel.rand(chars.length)] }.join

     view.concat(text_field :cadastro, "item_#{form_item.id}", :value=>chave, :readonly=>true)
    else
     view.concat(text_field :cadastro, "item_#{form_item.id}", options={:value=>params["item_#{form_item.id}"], :readonly=>true})
    end
    return view
  end

  def identificador_unico_ecm_edit_cadastro_item(form_item, cadastro, params)
    base = IdentificadorUnicoEcmBase.new
    cadastro_item = base.busca_cadastro_item(form_item, cadastro)
    view = ""
    view.concat(text_field :cadastro, "item_#{form_item.id}", options={:value=>cadastro_item.conteudo, :readonly=>true})
    return view
  end

  def identificador_unico_ecm_find_cadastro_item(form_item)
    view = ""
    view.concat(text_field :cadastro, "item_#{form_item.id}")
    return view
  end


  def identificador_unico_ecm_show_cadastro_item(form_item, cadastro)
    base = IdentificadorUnicoEcmBase.new
    cadastro_item = base.busca_cadastro_item(form_item, cadastro)
    return cadastro_item.conteudo
  end

  def identificador_unico_ecm_show_filtro_cadastro_item(form_item, cadastro)
    base = IdentificadorUnicoEcmBase.new
    cadastro_item = base.busca_cadastro_item(form_item, cadastro)
    return cadastro_item.conteudo
  end


  def texto_ajax
  end

end

