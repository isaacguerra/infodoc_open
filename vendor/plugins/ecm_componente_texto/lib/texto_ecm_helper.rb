module TextoEcmHelper
#================================================================
# helper para criação do item do formulario

  def texto_ecm_new_form_item
    view = ""
     view.concat("Item Texto")
     view.concat("<li> Este item receberá dados textuais, com tamanho maximo de 255 caracteres.</li>")
     view.concat("<table>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Largura:<br/>")
          view.concat(text_field "opcoes", :largura)
          view.concat("<li>Informe a largura da caixa de texto</li>")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Quant. Caracter:<br/>")
          view.concat(text_field "opcoes", :max_length)
          view.concat("<li>Informe a Quantidade de Caracteres</li>")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Aceita valor Vazio?:")
          view.concat(check_box "opcoes", :nulo)
          view.concat("<li>Informe o campo poderá ser Nulo(vazio)!</li>")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Forçar letras maiúsculas:")
          view.concat(check_box "opcoes", :maiusculo)
          view.concat("<li>Forçar o texto a ser maiúsculo!</li>")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Remover acentuação:")
          view.concat(check_box "opcoes", :semacento)
          view.concat("<li>Remover as acentuações do texto</li>")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Texto de Exemplo:<br/>")
          view.concat(text_field "opcoes", :exemplo)
          view.concat("<li>Informe um exemplo para o campo, se achar necessário</li>")
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

  def texto_ecm_edit_form_item(form_item)
    view = ""
     view.concat("Item Texto")
     view.concat("<li> Este item receberá dados textuais, com tamanho maximo de 255 caracteres.</li>")
     view.concat("<table>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Largura:<br/>")
          view.concat(text_field "opcoes", :largura, :value=>form_item.opcoes[:largura])
          view.concat("<li>Informe a largura da caixa de texto</li>")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Quant. Caracter:<br/>")
          view.concat(text_field "opcoes", :max_length, :value=>form_item.opcoes[:max_length])
          view.concat("<li>Informe a Quantidade de Caracteres</li>")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Aceita valor Vazio?:")
          view.concat(check_box "opcoes", :nulo)
          view.concat("<li>Informe o campo poderá ser Nulo(vazio)!</li>")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Forçar letras maiúsculas:")
          view.concat(check_box "opcoes", :maiusculo, :value=>form_item.opcoes[:maiusculo])
          view.concat("<li>Forçar o texto a ser maiúsculo!</li>")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Remover acentuação:")
          view.concat(check_box "opcoes", :semacento, :value=>form_item.opcoes[:semacento])
          view.concat("<li>Remover as acentuações do texto</li>")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Texto de Exemplo:<br/>")
          view.concat(text_field "opcoes", :exemplo, :value=>form_item.opcoes[:exemplo])
          view.concat("<li>Informe um exemplo para o campo, se achar necessário</li>")
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

  def texto_ecm_show_form_item(form_item)
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
        view.concat("Quant. Caracter:<br/>")
      view.concat("</td>")
      view.concat("<td class='lista_conteudo'>")
        view.concat(form_item.opcoes[:max_length])
      view.concat("</td>")
    view.concat("</tr>")
    view.concat("<tr>")
      view.concat("<td class='lista_item'>")
        view.concat("Sem Acento:<br/>")
      view.concat("</td>")
      view.concat("<td class='lista_conteudo'>")
        view.concat(form_item.opcoes[:semacento])
      view.concat("</td>")
    view.concat("</tr>")
    view.concat("<tr>")
      view.concat("<td class='lista_item'>")
        view.concat("Exemplo:<br/>")
      view.concat("</td>")
      view.concat("<td class='lista_conteudo'>")
        view.concat(form_item.opcoes[:exemplo])
      view.concat("</td>")
    view.concat("</tr>")
    view.concat("<tr>")
      view.concat("<td class='lista_item'>")
        view.concat("Nulo:<br/>")
      view.concat("</td>")
      view.concat("<td class='lista_conteudo'>")
        view.concat(form_item.opcoes[:nulo])
      view.concat("</td>")
    view.concat("</tr>")
    view.concat("<tr>")
      view.concat("<td class='lista_item'>")
        view.concat("Maiuscolo:<br/>")
      view.concat("</td>")
      view.concat("<td class='lista_conteudo'>")
        view.concat(form_item.opcoes[:maiusculo])
      view.concat("</td>")
    view.concat("</tr>")
  end

#===============================================================================
# helper de cadastro

  def texto_ecm_new_cadastro_item(form_item)
    view = ""
     view.concat(text_field :cadastro, "item_#{form_item.id}", options={:size=>form_item.opcoes[:largura], :maxlength=>form_item.opcoes[:max_length]})
     view.concat("<br><span class='form_item_exemplo'>#{form_item.opcoes[:exemplo]}</span>") if form_item.opcoes[:exemplo] != ""
     return view
  end

  def texto_ecm_edit_cadastro_item(form_item, cadastro_item)
    view = ""
     view.concat(text_field :cadastro, "item_#{form_item.id}" ,options={:value=>cadastro_item.conteudo, :size=>form_item.opcoes[:largura], :maxlength=>form_item.opcoes[:max_length]})
     view.concat("<br><span class='form_item_exemplo'>#{form_item.opcoes[:exemplo]}</span>") if form_item.opcoes[:exemplo] != ""
     return view
  end


  def texto_ecm_show_cadastro_item(form_item, cadastro_item)
    return cadastro_item.conteudo
  end

  def texto_ajax
  end
end
