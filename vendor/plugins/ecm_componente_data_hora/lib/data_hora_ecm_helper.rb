module DataHoraEcmHelper
#================================================================
# helper para criação do item do formulario

  def data_hora_ecm_new_form_item
    view = ""
    view.concat("<table>")
      view.concat("<tr>")
        view.concat("<td class='lista_item'/>")
        view.concat("<td class='lista_conteudo'>")
         view.concat("<h3>Item Data Hora</h3>")
         view.concat("<p>Este item criará um campo de Data</p>")
        view.concat("</td>")
       view.concat("</tr>") 
      view.concat("<tr>")
        view.concat("<td class='lista_item'>")
          view.concat("Informe o Ano Inicial:")
        view.concat("</td>")
        view.concat("<td class='lista_conteudo'>")
          view.concat(text_field "opcoes", :ano_inicio, :value=>"1900")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td class='lista_item'>")
          view.concat("Informe o Ano Final:")
        view.concat("</td>")
        view.concat("<td class='lista_conteudo'>")
          view.concat(text_field "opcoes", :ano_fim, :value=>"2020")
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td class='lista_item'>")
          view.concat("Bloquear Alteração:")
        view.concat("</td>")
        view.concat("<td class='lista_conteudo'>")
          view.concat(select "opcoes", :readonly, [["Não", 0],["Sim", 1]])
          view.concat("<p>Bloquear alteração da data, ficando a data e hora corrente!</p>")
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

  def data_hora_ecm_edit_form_item(form_item)
    view = ""
     view.concat("<table>")
      view.concat("<tr>")
        view.concat("<td class='lista_item'/>")
        view.concat("<td class='lista_conteudo'>")
         view.concat("<h3>Item Data Hora</h3>")
         view.concat("<p>Este item criará um campo de Data</p>")
        view.concat("<td/>")
       view.concat("</tr>") 
      view.concat("<tr>")
        view.concat("<td class='lista_item'>")
          view.concat("Informe o Ano Inicial:<br/>")
        view.concat("</td>")
        view.concat("<td class='lista_conteudo'>")  
          view.concat(text_field "opcoes", :ano_inicio, :value=>form_item.opcoes[:ano_inicio])
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
        view.concat("<td class='lista_item'>")
          view.concat("Informe o Ano Final:")
        view.concat("</td>")
        view.concat("<td class='lista_conteudo'>")  
          view.concat(text_field "opcoes", :ano_fim, :value=>form_item.opcoes[:ano_fim])
        view.concat("</td>")
      view.concat("</tr>")
      view.concat("<tr>")
       view.concat("<td class='lista_item'>")
          view.concat("Bloquear Alteração:")
       view.concat("</td>")
       view.concat("<td class='lista_conteudo'>")   
          view.concat(select "opcoes", :readonly, [["Não", 0],["Sim", 1]], :selected=>form_item.opcoes[:readonly].to_i)
          view.concat("<p>Bloquear alteração da data, ficando a data e hora corrente!</p>")
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

  def data_hora_ecm_show_form_item(form_item)
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

  def data_hora_ecm_new_cadastro_item(form_item, params)
    view = ""
    unless params
     if form_item.opcoes[:readonly] == "0"
        view.concat(datetime_select :cadastro, "item_#{form_item.id}", :order=>[:day, :month, :year], :start_year=>form_item.opcoes[:ano_inicio].to_i, :end_year=>form_item.opcoes[:ano_fim].to_i, :default=>DateTime.now)
      else
        view.concat(text_field :cadastro, "item_#{form_item.id}", :readonly=>true, :value=>Time.new.to_s)
      end
    else
      if form_item.opcoes[:readonly] == "0"
        view.concat(datetime_select :cadastro, "item_#{form_item.id}", :order=>[:day, :month, :year], :start_year=>form_item.opcoes[:ano_inicio].to_i, :end_year=>form_item.opcoes[:ano_fim].to_i, :default=>"#{params["item_#{form_item.id}(1i)"]}-#{params["item_#{form_item.id}(2i)"]}-#{params["item_#{form_item.id}(3i)"]}".to_date)
      else
        view.concat(text_field :cadastro, "item_#{form_item.id}", :readonly=>true, :value=>Time.new.to_s)
      end
    end
    return view
  end

  def data_hora_ecm_edit_cadastro_item(form_item, cadastro, params)
    base = DataHoraEcmBase.new
    cadastro_item = base.busca_cadastro_item(form_item, cadastro)
    view = ""
    if form_item.opcoes[:readonly] == "0"
        view.concat(datetime_select :cadastro, "item_#{form_item.id}", :order=>[:day, :month, :year], :start_year=>form_item.opcoes[:ano_inicio].to_i, :end_year=>form_item.opcoes[:ano_fim].to_i, :default=>cadastro_item.conteudo)
      else
        view.concat(text_field :cadastro, "item_#{form_item.id}", :readonly=>true, :value=>cadastro_item.conteudo.to_s)
      end
   return view
  end

  def data_hora_ecm_find_cadastro_item(form_item)
    view = "Entre"
    view.concat(datetime_select :cadastro, "item_inicio_#{form_item.id}", :order=>[:day, :month, :year], :start_year=>form_item.opcoes[:ano_inicio].to_i, :end_year=>form_item.opcoes[:ano_fim].to_i, :default=>Time.now)
    view.concat(" e ")
    view.concat(datetime_select :cadastro, "item_fim_#{form_item.id}", :order=>[:day, :month, :year], :start_year=>form_item.opcoes[:ano_inicio].to_i, :end_year=>form_item.opcoes[:ano_fim].to_i, :default=>Time.now)
    return view
  end


  def data_hora_ecm_show_cadastro_item(form_item, cadastro)
    base = DataHoraEcmBase.new
    cadastro_item = base.busca_cadastro_item(form_item, cadastro)
    return cadastro_item.conteudo.to_s
  end

  def data_hora_ecm_show_filtro_cadastro_item(form_item, cadastro)
    base = DataHoraEcmBase.new
    cadastro_item = base.busca_cadastro_item(form_item, cadastro)
    return cadastro_item.conteudo.to_s
  end


  def texto_ajax
  end

end

