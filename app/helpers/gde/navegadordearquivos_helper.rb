module Gde::NavegadordearquivosHelper

  def lista_formulario(formulario)
    view = "<ul>"
    formulario.formularios_relacionados_filhos.each do |rel|
      view.concat("<li>")
      view.concat(rel.titulo)
      view.concat(lista_formulario(rel))
      view.concat("</li>")
    end
    formulario.cadastros.each do |cad|
    view.concat("<li>")
    view.concat(link_to ecm_show_cadastro_item(formulario.item_principal, cad), ecm_formulario_cadastro_path(cad.formulario_id, cad))
      view.concat("<ul>")
      cad.children.each do |art|
        view.concat("<div class=#{art.artefato.mime_type}>")
          view.concat("<li>")
            view.concat(check_box_tag "artefatos[]", art.id)
            view.concat(art.artefato.objeto_file_name)
          view.concat("</li>")
        view.concat("</div>")
      end
      view.concat("</ul>")
    view.concat("</li>")
    end
    view.concat("</ul>")
    return view
  end
end

