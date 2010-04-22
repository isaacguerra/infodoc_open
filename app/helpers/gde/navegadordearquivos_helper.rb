module Gde::NavegadordearquivosHelper

  def lista_formulario(formulario)
    view = "<ul id='navegacao_arquivos' class='filetree'>"
    formulario.formularios_relacionados_filhos.each do |rel|
      view.concat("<li><span class='folder'><h4>")
      view.concat(rel.titulo)
      view.concat("</h4></span>")
      view.concat(lista_formulario(rel))
      view.concat("</li>")
    end
    formulario.cadastros.each do |cad|
    view.concat("<li><span class='folder'><h4>")
    if cad.formulario.permissao(@sessao_usuario.usuario) > 0
     view.concat(link_to ecm_show_cadastro_item(formulario.item_principal, cad), ecm_formulario_cadastro_path(cad.formulario_id, cad))
    else
     view.concat(ecm_show_cadastro_item(formulario.item_principal, cad))
    end
    view.concat("</h4></span class='folder'>")
      view.concat("<ul>")
      cad.children.each do |art|
        
          view.concat("<li>")
          view.concat("<span  class='#{art.artefato.mime_type} file'>")
            if cad.formulario.permissao(@sessao_usuario.usuario) > 0
             view.concat(link_to art.artefato.objeto_file_name, download_gde_navegadordearquivo_path(art))
            else
             view.concat(art.artefato.objeto_file_name)
            end
           view.concat("</span>")
          view.concat("</li>")

      end
      view.concat("</ul>")
    view.concat("</li>")
    end
    view.concat("</ul>")
    return view
  end
end

