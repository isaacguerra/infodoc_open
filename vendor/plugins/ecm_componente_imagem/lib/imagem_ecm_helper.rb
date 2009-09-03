module ImagemEcmHelper
#================================================================
# helper para criação do item do formulario

  def imagem_ecm_new_form_item
    view = ""
     view.concat("Item Imagem")
     view.concat("<li> Este campo vilculará uma imagem ao formulario</li>")
     view.concat("<table>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Tipos:<br/>")
          view.concat(text_area "opcoes", :tipo, options={:cols=>50, :rows=>10})
          view.concat("<li>Informe a Lista de Tipos separando por ; </li>")
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

  def imagem_ecm_edit_form_item(form_item)
    view = ""
     view.concat("Item Imagem")
     view.concat("<li> Este campo vilculará uma imagem ao formulario</li>")
     view.concat("<table>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Tipos:<br/>")
          view.concat(text_area "opcoes", :tipo, options={:cols=>50, :rows=>10, :value=>form_item.opcoes[:lista]})
          view.concat("<li>Informe a Lista de Tipos separando por ; </li>")
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

  def imagem_ecm_show_form_item(form_item)
    view = ""
    view.concat("<tr>")
      view.concat("<td class='imagem_item'>")
        view.concat("Tipos")
      view.concat("</td>")
      view.concat("<td class='imagem_conteudo'>")
        view.concat(form_item.opcoes[:tipo])
      view.concat("</td>")
    view.concat("</tr>")
  end

#===============================================================================
# helper de cadastro

  def imagem_ecm_new_cadastro_item(form_item, params)
    view = ""
    view.concat(file_field :cadastro, "item_#{form_item.id}")
    return view
  end

  def imagem_ecm_edit_cadastro_item(form_item, cadastro_item, params)
    view = ""
    view.concat(file_field :cadastro, "item_#{form_item.id}")
    return view
  end

  def imagem_ecm_find_cadastro_item(form_item)
    view = ""
    return view
  end


  def imagem_ecm_show_cadastro_item(form_item, cadastro_item)
    view = ""
    view.concat(image_tag(cadastro_item.imagem.url)) if cadastro_item
    return view
  end

  def imagem_ecm_show_filtro_cadastro_item(form_item, cadastro_item)
    view = ""
    return view
  end


  def imagem_ajax
  end
end

