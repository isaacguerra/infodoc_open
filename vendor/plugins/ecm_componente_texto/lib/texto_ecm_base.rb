class TextoEcmBase

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
      if form_item.opcoes[:unico] == "1"
        cadastro_itens["item_#{form_item.id}"].upcase! if form_item.opcoes[:semacento] == "1"
        cadastro_itens["item_#{form_item.id}"].remover_acentos! if form_item.opcoes[:maiusculo] == "1"

        cad = EcmItemTexto.find(:first, :conditions=>["itensformulario_id = ? and conteudo = ? and cadastro_id = ?", form_item.id, cadastro_itens["item_#{form_item.id}"], cadastro.id])
        unless cad
          num = EcmItemTexto.count(:all, :conditions=>["itensformulario_id = ? and conteudo = ?", form_item.id, cadastro_itens["item_#{form_item.id}"]])
          cadastro.errors.add("item_#{form_item.id}", "O #{form_item.rotulo} ja foi cadastrado anteriormente!") if num > 0
        else
          unless cad.conteudo == cadastro_itens["item_#{form_item.id}"]
            num = EcmItemTexto.count(:all, :conditions=>["itensformulario_id = ? and conteudo = ?", form_item.id, cadastro_itens["item_#{form_item.id}"]])
            cadastro.errors.add("item_#{form_item.id}", "O #{form_item.rotulo} ja foi cadastrado anteriormente!") if num > 0
          end
        end
      end

      if form_item.opcoes[:regex] != ""
        reg = Regexp.new(form_item.opcoes[:regex])
        cadastro.errors.add("item_#{form_item.id}", "O conteúdo de #{form_item.rotulo} não é válido") unless reg.match(cadastro_itens["item_#{form_item.id}"])
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
      texto.conteudo.remover_acentos! if form_item.opcoes[:semacento] == "1"
      texto.conteudo.upcase! if form_item.opcoes[:maiusculo] == "1"
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

   def busca_avancada(form_item, params)
      cads = EcmItemTexto.find(:all, :conditions=>["itensformulario_id = ? and
                                                    conteudo like ?",
                                                    form_item.id,
                                                    "%#{params[:cadastro]["item_#{form_item.id}"]}%"]).collect {|c| c.cadastro_id}
   end
end

