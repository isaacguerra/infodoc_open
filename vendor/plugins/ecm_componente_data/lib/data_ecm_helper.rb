module DataEcmHelper
#================================================================
# helper para criação do item do formulario

  def data_ecm_new_form_item
    view = ""
     view.concat("Item Texto")
     view.concat("<li>Este item criará um campo de Data</li>")
     view.concat("<table>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Informe o Ano Inicial:<br/>")
          view.concat(text_field "opcoes", :ano_inicio, :value=>"1900")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Informe o Ano Final:<br/>")
          view.concat(text_field "opcoes", :ano_fim, :value=>"2020")
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

  def data_ecm_edit_form_item(form_item)
    view = ""
     view.concat("Item Texto")
     view.concat("<li>Este item criará um campo de Data</li>")
     view.concat("<table>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Informe o Ano Inicial:<br/>")
          view.concat(text_field "opcoes", :ano_inicio, :value=>form_item.opcoes[:ano_inicio])
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td>")
          view.concat("Informe o Ano Final:<br/>")
          view.concat(text_field "opcoes", :ano_fim, :value=>form_item.opcoes[:ano_fim])
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

  def data_ecm_show_form_item(form_item)
    view = ""
    view.concat("<tr>")
      view.concat("<td class='lista_item'>")
        view.concat("Ano inicial")
      view.concat("</td>")
      view.concat("<td class='lista_conteudo'>")
        view.concat(form_item.opcoes[:ano_inicio])
      view.concat("</td>")
    view.concat("</tr>")
    view.concat("<tr>")
      view.concat("<td class='lista_item'>")
        view.concat("Ano Final:<br/>")
      view.concat("</td>")
      view.concat("<td class='lista_conteudo'>")
        view.concat(form_item.opcoes[:ano_fim])
      view.concat("</td>")
    view.concat("</tr>")
  end

#===============================================================================
# helper de cadastro

  def data_ecm_new_cadastro_item(form_item, params)
    view = ""
    unless params
     view.concat(date_select :cadastro, "item_#{form_item.id}", :order=>[:day, :month, :year], :start_year=>form_item.opcoes[:ano_inicio].to_i, :end_year=>form_item.opcoes[:ano_fim].to_i, :default=>Date.today)
    else
     view.concat(date_select :cadastro, "item_#{form_item.id}", :order=>[:day, :month, :year], :start_year=>form_item.opcoes[:ano_inicio].to_i, :end_year=>form_item.opcoes[:ano_fim].to_i, :default=>"#{params["item_#{form_item.id}(1i)"]}-#{params["item_#{form_item.id}(2i)"]}-#{params["item_#{form_item.id}(3i)"]}".to_date)
    end
    return view
  end

  def data_ecm_edit_cadastro_item(form_item, cadastro, params)
    base = DataEcmBase.new
    cadastro_item = base.busca_cadastro_item(form_item, cadastro)
    view = ""
    view.concat(date_select :cadastro, "item_#{form_item.id}", :order=>[:day, :month, :year], :start_year=>form_item.opcoes[:ano_inicio].to_i, :end_year=>form_item.opcoes[:ano_fim].to_i, :default=>cadastro_item.conteudo)
    return view
  end

  def data_ecm_find_cadastro_item(form_item)
    view = "Entre"
    view.concat(date_select :cadastro, "item_inicio_#{form_item.id}", :order=>[:day, :month, :year], :start_year=>form_item.opcoes[:ano_inicio].to_i, :end_year=>form_item.opcoes[:ano_fim].to_i, :default=>Date.today)
    view.concat(" e ")
    view.concat(date_select :cadastro, "item_fim_#{form_item.id}", :order=>[:day, :month, :year], :start_year=>form_item.opcoes[:ano_inicio].to_i, :end_year=>form_item.opcoes[:ano_fim].to_i, :default=>Date.today)
    return view
  end


  def data_ecm_show_cadastro_item(form_item, cadastro)
    base = DataEcmBase.new
    cadastro_item = base.busca_cadastro_item(form_item, cadastro)
    return cadastro_item.conteudo.to_s_br
  end

  def data_ecm_show_filtro_cadastro_item(form_item, cadastro)
    base = DataEcmBase.new
    cadastro_item = base.busca_cadastro_item(form_item, cadastro)
    return cadastro_item.conteudo.to_s_br
  end


  def texto_ajax
  end


end

