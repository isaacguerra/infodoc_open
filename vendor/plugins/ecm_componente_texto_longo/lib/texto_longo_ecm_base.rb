class TextoLongoEcmBase

   def validar_opcoes(form_item)
      return true
   end

   def acessores(cadastro, item_form)
      cadastro.acessores("item_#{item_form.id}")
   end

   def validar(cadastro, form_item, cadastro_itens)
      if form_item.opcoes[:nulo] == "0" and cadastro_itens["item_#{form_item.id}"] == ""
        cadastro.errors.add("item_#{form_item.id}", "Campo #{form_item.rotulo} Requerido!")
      end
   end

   def save(cadastro, form_item, cadastro_itens)
      texto_longo = EcmItemTextoLongo.new
      texto_longo.entidade_id = cadastro.entidade_id
      texto_longo.formulariocategoria_id = cadastro.formulario.formulariocategoria_id
      texto_longo.formulario_id = cadastro.formulario_id
      texto_longo.itensformulario_id = form_item.id
      texto_longo.cadastro_id = cadastro.id
      texto_longo.conteudo = cadastro_itens["item_#{form_item.id}"]
      texto_longo.save
   end

   def update(cadastro, form_item, cadastro_itens)
     texto_longo = EcmItemTextoLongo.find(:first, :conditions=>["entidade_id = ? and
                                                   formulariocategoria_id = ? and
                                                   formulario_id = ? and
                                                   itensformulario_id = ? and
                                                   cadastro_id = ?",
                                                   cadastro.entidade_id,
                                                   cadastro.formulariocategoria_id,
                                                   cadastro.formulario_id,
                                                   form_item.id,
                                                   cadastro.id])
      texto_longo.conteudo = cadastro_itens["item_#{form_item.id}"]
      texto_longo.save
   end

   def busca_avancada(form_item, params)
      cads = EcmItemTextoLongo.find(:all, :conditions=>["itensformulario_id = ? and
                                                    conteudo like ?",
                                                    form_item.id,
                                                    "%#{params[:cadastro]["item_#{form_item.id}"]}%"]).collect {|c| c.cadastro_id}
      return cads
   end
end

