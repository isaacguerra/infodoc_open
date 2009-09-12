class SomaReferenciaEcmBase
#-----------------------------------------------------------------------------------------------------------------------------------------------------
# ITEM DO FORMULARIO
  def salvar_item(item_form, params)
    opcoes = []
    opcoes << params[:opcoes]
    opcoes << params[:filtro]
    opcoes << params[:cadastro]
    opcoes << params[:soma]
    item_form.opcoes = opcoes
    return item_form.save
  end

  def apos_criar_item(form_item)
#    if form_item.formulario.cadastros.size > 0
#      #===========================================================================================================================
#      formulario = Formulario.find(form_item.opcoes[0][:referenciado])
#      principal = Itensformulario.find(formulario.principal_id)
#      cads = []
#      res = []
#      tudo = true
#      formulario.itensformularios.each do |item|
#        if form_item[:opcoes][1]["check_#{item.id}"] == "1"
#          tudo = false
#          filtro = eval("#{item.itenstipo.componente.camelize}EcmBase.new")
#          cads << filtro.busca_avancada(item, nil, form_item[:opcoes][2]["item_#{item.id}"])
#          if cads.size > 0
#            res = cads[0]
#            cads.each do |c|
#              res = res & c
#            end
#          end
#        end
#      end
#      unless tudo
#        cadastro_itens = EcmItemTexto.do_formulario(formulario.id).do_itens_formulario(formulario.principal_id).find(:first, :select=>"cadastro_id, conteudo", :conditions=>["cadastro_id in (?)", res])
#      else
#        cadastro_itens = EcmItemTexto.do_formulario(formulario.id).do_itens_formulario(formulario.principal_id).find(:first, :select=>"cadastro_id, conteudo")
#      end
#      #===========================================================================================================================
#      form_item.formulario.cadastros.each do |cadastro|
#        texto = EcmItemReferencia.new
#        texto.entidade_id = cadastro.entidade_id
#        texto.formulariocategoria_id = cadastro.formulario.formulariocategoria_id
#        texto.formulario_id = cadastro.formulario_id
#        texto.itensformulario_id = form_item.id
#        texto.cadastro_id = cadastro.id
#        texto.referencia_id = cadastro_itens.cadastro_id
#        texto.save
#      end
#    end
  end

#-----------------------------------------------------------------------------------------------------------------------------------------------------
# CADASTRO
#
   def validar_opcoes(form_item)
      return true
   end

   def acessores(cadastro, item_form)
      #cadastro.acessores("item_#{item_form.id}")
   end

   def validar(cadastro, form_item, cadastro_itens)
#      unless cadastro_itens["item_#{form_item.id}"]
#        cadastro.errors.add("item_#{form_item.id}", "Campo #{form_item.rotulo} Requerido!")
#      end
      return true
   end

   def save(cadastro, form_item, cadastro_itens)
#      texto = EcmItemReferencia.new
#      texto.entidade_id = cadastro.entidade_id
#      texto.formulariocategoria_id = cadastro.formulario.formulariocategoria_id
#      texto.formulario_id = cadastro.formulario_id
#      texto.itensformulario_id = form_item.id
#      texto.cadastro_id = cadastro.id
#      texto.referencia_id = cadastro_itens["item_#{form_item.id}"]
#      texto.save
   end

   def update(cadastro, form_item, cadastro_itens)
#     texto = EcmItemReferencia.find(:first, :conditions=>["entidade_id = ? and
#                                                   formulariocategoria_id = ? and
#                                                   formulario_id = ? and
#                                                   itensformulario_id = ? and
#                                                   cadastro_id = ?",
#                                                   cadastro.entidade_id,
#                                                   cadastro.formulariocategoria_id,
#                                                   cadastro.formulario_id,
#                                                   form_item.id,
#                                                   cadastro.id])
#      texto.referencia_id = cadastro_itens["item_#{form_item.id}"]
#      texto.save
   end

   def busca_avancada(form_item, params, valor=nil)
#      unless valor
#        cads = EcmItemReferencia.find(:all, :conditions=>["itensformulario_id = ? and
#                                                    referencia_id = ?",
#                                                    form_item.id,
#                                                    params[:cadastro]["item_#{form_item.id}"]]).collect {|c| c.cadastro_id}
#     else
#       cads = EcmItemReferencia.find(:all, :conditions=>["itensformulario_id = ? and
#                                                    referencia_id = ?",
#                                                    form_item.id, valor]).collect {|c| c.cadastro_id}
#     end
   end

   def deleta_cadastro_item
   end
end

