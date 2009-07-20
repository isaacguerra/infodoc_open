class NumeroInteiroEcmBase

   def validar_opcoes(form_item)
      return true
   end

   def acessores(cadastro, item_form)
    cadastro.instance_eval do
      eval("@item_#{item_form.id}")
      eval("def item_#{item_form.id}=(valor) @item_#{item_form.id}=valor end")
      eval("def item_#{item_form.id}() return @item_#{item_form.id} end")
    end
   end

   def validar(cadastro, form_item, cadastro_itens)
      if form_item.opcoes[:nulo] == "0" and cadastro_itens["item_#{form_item.id}"] == ""
        cadastro.errors.add("Item #{form_item.id}", ". Campo #{form_item.rotulo} Requerido!")
      end
      if form_item.opcoes[:unico] == "1"
        cadastro_itens["item_#{form_item.id}"].upcase! if form_item.opcoes[:semacento] == "1"
        cadastro_itens["item_#{form_item.id}"].remover_acentos! if form_item.opcoes[:maiusculo] == "1"

        cad = EcmItemNumeroInteiro.find(:first, :conditions=>["itensformulario_id = ? and conteudo = ? and cadastro_id = ?", form_item.id, cadastro_itens["item_#{form_item.id}"], cadastro.id])
        unless cad
          num = EcmItemNumeroInteiro.count(:all, :conditions=>["itensformulario_id = ? and conteudo = ?", form_item.id, cadastro_itens["item_#{form_item.id}"]])
          cadastro.errors.add("item_#{form_item.id}", "O #{form_item.rotulo} ja foi cadastrado anteriormente!") if num > 0
        else
          unless cad.conteudo == cadastro_itens["item_#{form_item.id}"]
            num = EcmItemNumeroInteiro.count(:all, :conditions=>["itensformulario_id = ? and conteudo = ?", form_item.id, cadastro_itens["item_#{form_item.id}"]])
            cadastro.errors.add("item_#{form_item.id}", "O #{form_item.rotulo} ja foi cadastrado anteriormente!") if num > 0
          end
        end
      end
   end

   def save(cadastro, form_item, cadastro_itens)
      numero_inteiro = EcmItemNumeroInteiro.new
      numero_inteiro.entidade_id = cadastro.entidade_id
      numero_inteiro.formulariocategoria_id = cadastro.formulario.formulariocategoria_id
      numero_inteiro.formulario_id = cadastro.formulario_id
      numero_inteiro.itensformulario_id = form_item.id
      numero_inteiro.cadastro_id = cadastro.id
      numero_inteiro.conteudo = cadastro_itens["item_#{form_item.id}"]
      numero_inteiro.save
   end

   def update(cadastro, form_item, cadastro_itens)
     numero_inteiro = EcmItemNumeroInteiro.find(:first, :conditions=>["entidade_id = ? and
                                                                       formulariocategoria_id = ? and
                                                                       formulario_id = ? and
                                                                       itensformulario_id = ? and
                                                                       cadastro_id = ?",
                                                                       cadastro.entidade_id,
                                                                       cadastro.formulariocategoria_id,
                                                                       cadastro.formulario_id,
                                                                       form_item.id,
                                                                       cadastro.id])
      numero_inteiro.conteudo = cadastro_itens["item_#{form_item.id}"]
      numero_inteiro.save
   end
end

