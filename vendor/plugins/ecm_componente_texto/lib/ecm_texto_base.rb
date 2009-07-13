class EcmTextoBase
   def acessores(cadastro, item)
    cadastro.instance_eval do
      eval("@item_#{item.id}")
      eval("def item_#{item.id}=(valor) @item_#{item.id}=valor end")
      eval("def item_#{item.id}() return @item_#{item.id} end")
    end
   end

   def validar(cadastro, item, itens_form)
      if item.opcoes[:nulo] == "0" and itens_form["item_#{item.id}"] == ""
        cadastro.errors.add("Campo #{item.rotulo} Requerido!")
      end
   end

   def save(cadastro, item, itens_form)
      texto = EcmItemTexto.new
      texto.entidade_id = cadastro.entidade_id
      texto.formulariocategoria_id = cadastro.formulario.formulariocategoria_id
      texto.formulario_id=cadastro.formulario_id
      texto.itensformulario_id = item.id
      texto.cadastro_id = cadastro.id
      texto.conteudo = itens_form["item_#{item.id}"]
      texto.save
   end

   def update(cadastro, item, itens_form)
     texto = EcmItemTexto.find(:first, :conditions=>["entidade_id = ? and
                                                   formulariocategoria_id = ? and
                                                   formulario_id = ? and
                                                   itensformulario_id = ? and
                                                   cadastro_id = ?",
                                                   cadastro.entidade_id,
                                                   cadastro.formulariocategoria_id,
                                                   cadastro.formulario_id,
                                                   item.id,
                                                   cadastro.id])
      texto.conteudo = itens_form["item_#{item.id}"]
      texto.save
   end
end

