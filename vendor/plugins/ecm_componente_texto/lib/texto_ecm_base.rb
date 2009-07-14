class TextoEcmBase
   def acessores(cadastro, item_form)
    cadastro.instance_eval do
      eval("@item_#{item_form.id}")
      eval("def item_#{item_form.id}=(valor) @item_#{item_form.id}=valor end")
      eval("def item_#{item_form.id}() return @item_#{item_form.id} end")
    end
   end

   def validar(cadastro, form_item, cadastro_itens)
      if form_item.opcoes[:nulo] == "0" and cadastro_itens["item_#{form_item.id}"] == ""
        cadastro.errors.add("Campo #{form_item.rotulo} Requerido!")
      end
   end

   def save(cadastro, form_item, cadastro_itens)
      texto = EcmItemTexto.new
      texto.entidade_id = cadastro.entidade_id
      texto.formulariocategoria_id = cadastro.formulario.formulariocategoria_id
      texto.formulario_id = cadastro.formulario_id
      texto.itensformulario_id = form_item.id
      texto.cadastro_id = cadastro.id
      texto.conteudo = cadastro_itens["item_#{form_item.id}"]
      texto.save
   end

   def update(cadastro, form_item, cadastro_itens)
     texto = EcmItemTexto.find(:first, :conditions=>["entidade_id = ? and
                                                   formulariocategoria_id = ? and
                                                   formulario_id = ? and
                                                   itensformulario_id = ? and
                                                   cadastro_id = ?",
                                                   cadastro.entidade_id,
                                                   cadastro.formulariocategoria_id,
                                                   cadastro.formulario_id,
                                                   form_item.id,
                                                   cadastro.id])
      texto.conteudo = cadastro_itens["item_#{form_item.id}"]
      texto.save
   end
end

