# Class que contem os helpers do componente NUMERO_INTEIRO
module NumeroInteiroEcmHelper
#===============================================================================
#                         helpers de foumulário
# helper para CRIAÇÃO do item do formulario

  def numero_inteiro_ecm_new_form_item
    view = ""
      view.concat("<table>")
       view.concat("<tr>")
         view.concat("<td class='lista_item'/>")
         view.concat("<td class='lista_conteudo'>")
            view.concat("<h3>Item Numero Inteiro</h3>")
            view.concat("<p> Este item receberá númerios inteiros</p>")
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
           view.concat("Quantidade de Caracteres:")
         view.concat("</td>")
         view.concat("<td class='lista_conteudo'>")
           view.concat(text_field "opcoes", :max_length)
           view.concat("<p>Informe a quantidade máxima de caracteres</p>")
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
         view.concat("<td class='lista_item'>")
           view.concat("Impedir Duplicação no Registro")
         view.concat("</td>")
         view.concat("<td class='lista_conteudo'>")
           view.concat(select "opcoes", :unico, [["Ativo", 1], ["Inativo", 0]])
            view.concat("<p>O campo não aceitará dois registros com o mesmo valor!</p>")
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
# Helper para EDIÇÃO do item no formulario

  def numero_inteiro_ecm_edit_form_item(form_item)
    view = ""
      view.concat("<table>")
       view.concat("<tr>")
         view.concat("<td class='lista_item'/>")
         view.concat("<td class='lista_conteudo'>")
            view.concat("<h3>Item Numero Inteiro</h3>")
            view.concat("<p> Este item receberá númerios inteiros</p>")
         view.concat("</td>")
       view.concat("</tr>")
         view.concat("<tr>")
           view.concat("<td class='lista_item'>")
             view.concat("Largura do Campo:<br/>")
           view.concat("</td>")
           view.concat("<td class='lista_conteudo'>")
             view.concat(text_field "opcoes", :largura, :value=>form_item.opcoes[:largura])
             view.concat("<p>Informe a largura da caixa de texto</p>")
           view.concat("</td>")
         view.concat("</tr>")
         view.concat("<tr>")
           view.concat("<td class='lista_item'>")
             view.concat("Quantidade de Caracteres:")
           view.concat("</td>")
           view.concat("<td class='lista_conteudo'>")
             view.concat(text_field "opcoes", :max_length, :value=>form_item.opcoes[:max_length])
             view.concat("<p>Informe a quantidade máxima de caracteres</p>")
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
           view.concat("<td class='lista_item'>")
             view.concat("Impedir Duplicação no Registro")
           view.concat("</td>")
           view.concat("<td class='lista_conteudo'>")  
             view.concat(select "opcoes", :unico, [["Ativo", 1], ["Inativo", 0]], :selected=>form_item.opcoes[:unico].to_i)
             view.concat("<p>O campo não aceitará dois registros com o mesmo valor!</p>")
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
# Helper para EXIBIÇÃO do item no formulario
  def numero_inteiro_ecm_show_form_item(form_item)
    view = ""
    view.concat("<tr>")
      view.concat("<td class='lista_item'>")
        view.concat("Largura")
      view.concat("</td>")
      view.concat("<td class='lista_conteudo'>")
        view.concat(form_item.opcoes[:largura])
      view.concat("</td>")
    view.concat("</tr>")
      view.concat("<td class='lista_item'>")
        view.concat("Quantidade de Caracteres")
      view.concat("</td>")
      view.concat("<td class='lista_conteudo'>")
        view.concat(form_item.opcoes[:max_length])
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
    view.concat("<tr>")
      view.concat("<td class='lista_item'>")
        view.concat("Impedir Duplicação no Registro<br/>")
      view.concat("</td>")
      view.concat("<td class='lista_conteudo'>")
        view.concat(status(form_item.opcoes[:unico]))
      view.concat("</td>")
    view.concat("</tr>")
  end

#===============================================================================
#                     helpers de cadastro
# São necessários helpers para criação, edição, exibição e busca dos itens no
# cadastro porque as informações contidas em um cadastro não estão em uma única
# tabela no banco de dados, e sim diluidas em outras tabelas, de acordo com o
# tipo de informação que cada item do cadastro.

# Helper para CRIAÇÃO do item no cadastro

  def numero_inteiro_ecm_new_cadastro_item(form_item, params)
    view = ""
    unless params
      view.concat(text_field :cadastro, "item_#{form_item.id}", options={:size=>form_item.opcoes[:largura], :maxlength=>form_item.opcoes[:max_length]})
    else
      view.concat(text_field :cadastro, "item_#{form_item.id}", options={:value=>params["item_#{form_item.id}"], :size=>form_item.opcoes[:largura], :maxlength=>form_item.opcoes[:max_length]})
    end
    return view
  end
#-------------------------------------------------------------------------------

# Helper para EDIÇÃO do item no cadastro

  def numero_inteiro_ecm_edit_cadastro_item(form_item, cadastro, params)
    base = NumeroInteiroEcmBase.new
    cadastro_item = base.busca_cadastro_item(form_item, cadastro)
    view = ""
     view.concat(text_field :cadastro, "item_#{form_item.id}" ,options={:value=>cadastro_item.conteudo, :size=>form_item.opcoes[:largura], :maxlength=>form_item.opcoes[:max_length]})
     return view
  end
#-------------------------------------------------------------------------------

# Helper que possibilita a execução de FIND do item no cadastro.

  def numero_inteiro_ecm_find_cadastro_item(form_item)
    view = "Entre "
    view.concat(text_field :cadastro, "item_#{form_item.id}_1", options={:size=>form_item.opcoes[:largura], :maxlength=>form_item.opcoes[:max_length]})
    view.concat(" e ")
    view.concat(text_field :cadastro, "item_#{form_item.id}_2", options={:size=>form_item.opcoes[:largura], :maxlength=>form_item.opcoes[:max_length]})
    return view
  end
#-------------------------------------------------------------------------------

# Helper para EXIBIÇÃO do item no cadastro

  def numero_inteiro_ecm_show_cadastro_item(form_item, cadastro)
    base = NumeroInteiroEcmBase.new
    cadastro_item = base.busca_cadastro_item(form_item, cadastro)
    return cadastro_item.conteudo
  end
#-------------------------------------------------------------------------------

# Helper para exibição do item no FILTRO de forma diferente do show.

  def numero_inteiro_ecm_show_filtro_cadastro_item(form_item, cadastro)
    base = NumeroInteiroEcmBase.new
    cadastro_item = base.busca_cadastro_item(form_item, cadastro)
    return cadastro_item.conteudo
  end
#-------------------------------------------------------------------------------

# Helper que possibilita a criação de AJAX diretamente no plugin.

  def numero_inteiro_ajax
  end

end

