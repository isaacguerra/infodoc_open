module ListaEcmHelper
#================================================================
# helper para criação do item do formulario

  def lista_ecm_new_form_item
    view = ""
     view.concat("Item Texto")
     view.concat("<li> Este item exibirá uma lista estática predefinida.</li>")
     view.concat("<table>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Lista:<br/>")
          view.concat(text_area "opcoes", :lista, options={:cols=>50, :rows=>10})
          view.concat("<li>Informe os Itens da Lista separando por ; os elementos</li>")
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

  def lista_ecm_edit_form_item(form_item)
    view = ""
     view.concat("Item Texto")
     view.concat("<li> Este item exibirá uma lista estática predefinida.</li>")
     view.concat("<table>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Lista:<br/>")
          view.concat(text_area "opcoes", :lista, options={:cols=>50, :rows=>10, :value=>form_item.opcoes[:lista]})
          view.concat("<li>Informe os Itens da Lista separando por ; os elementos</li>")
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

  def lista_ecm_show_form_item(form_item)
    view = ""
    view.concat("<tr>")
      view.concat("<td class='lista_item'>")
        view.concat("Lista")
      view.concat("</td>")
      view.concat("<td class='lista_conteudo'>")
        view.concat(form_item.opcoes[:lista])
      view.concat("</td>")
    view.concat("</tr>")
  end

#===============================================================================
# helper de cadastro

  def lista_ecm_new_cadastro_item(form_item, params)
    view = ""
    lista = form_item.opcoes[:lista].split(";").sort
    unless params
      view.concat(select :cadastro, "item_#{form_item.id}", lista)
    else
      view.concat(select :cadastro, "item_#{form_item.id}", lista, :selected=>params["item_#{form_item.id}"])
    end
    return view
  end

  def lista_ecm_edit_cadastro_item(form_item, cadastro, params)
    base = ListaEcmBase.new
    cadastro_item = base.busca_cadastro_item(form_item, cadastro)
    view = ""
    lista = form_item.opcoes[:lista].split(";").sort
    unless params
      view.concat(select :cadastro, "item_#{form_item.id}", lista, :selected=>cadastro_item.conteudo)
    else
      view.concat(select :cadastro, "item_#{form_item.id}", lista, :selected=>params[:cadastro]["item_#{form_item.id}"])
    end
    return view
  end

  def lista_ecm_find_cadastro_item(form_item)
    view = ""
    lista = form_item.opcoes[:lista].split(";").sort
    view.concat(select :cadastro, "item_#{form_item.id}", lista)
    return view
  end


  def lista_ecm_show_cadastro_item(form_item, cadastro)
    base = ListaEcmBase.new
    cadastro_item = base.busca_cadastro_item(form_item, cadastro)
    return cadastro_item.conteudo
  end

  def lista_ecm_show_filtro_cadastro_item(form_item, cadastro)
    base = ListaEcmBase.new
    cadastro_item = base.busca_cadastro_item(form_item, cadastro)
    return cadastro_item.conteudo
  end

  def lista_ajax
  end


end

