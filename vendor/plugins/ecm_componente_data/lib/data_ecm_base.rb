class DataEcmBase
#-----------------------------------------------------------------------------------------------------------------------------------------------------
# ITEM DO FORMULARIO
  def salvar_item(item_form, params)
    item_form.opcoes = params[:opcoes]
    return item_form.save
  end

  def apos_criar_item(form_item)
    if form_item.formulario.cadastros.size > 0
      form_item.formulario.cadastros.each do |cadastro|
        texto = EcmItemData.new
        texto.entidade_id = cadastro.entidade_id
        texto.formulariocategoria_id = cadastro.formulario.formulariocategoria_id
        texto.formulario_id = cadastro.formulario_id
        texto.itensformulario_id = form_item.id
        texto.cadastro_id = cadastro.id
        texto.conteudo = Date.today.to_s
        texto.save
      end
    end
  end

  def remover_filtro_em_referencia(form_item, deleta_form_item)
    return true
  end

#-----------------------------------------------------------------------------------------------------------------------------------------------------
# CADASTRO
#

   def validar_opcoes(form_item)
      return true
   end

   def acessores(cadastro, item_form)
      cadastro.acessores("item_#{item_form.id}")
   end

   def validar(cadastro, form_item, cadastro_itens)
      unless cadastro_itens["item_#{form_item.id}(3i)"]
        cadastro.errors.add("item_#{form_item.id}", "Campo #{form_item.rotulo} Requerido!")
      end
   end

   def save(cadastro, form_item, cadastro_itens)
      texto = EcmItemData.new
      texto.entidade_id = cadastro.entidade_id
      texto.formulariocategoria_id = cadastro.formulario.formulariocategoria_id
      texto.formulario_id = cadastro.formulario_id
      texto.itensformulario_id = form_item.id
      texto.cadastro_id = cadastro.id
      data = "#{cadastro_itens["item_#{form_item.id}(1i)"]}-#{cadastro_itens["item_#{form_item.id}(2i)"]}-#{cadastro_itens["item_#{form_item.id}(3i)"]}"
      texto.conteudo = data
      texto.save
   end

   def update(cadastro, form_item, cadastro_itens)
     texto = EcmItemData.find(:first, :conditions=>["entidade_id = ? and
                                                   formulariocategoria_id = ? and
                                                   formulario_id = ? and
                                                   itensformulario_id = ? and
                                                   cadastro_id = ?",
                                                   cadastro.entidade_id,
                                                   cadastro.formulariocategoria_id,
                                                   cadastro.formulario_id,
                                                   form_item.id,
                                                   cadastro.id])
      data = "#{cadastro_itens["item_#{form_item.id}(1i)"]}-#{cadastro_itens["item_#{form_item.id}(2i)"]}-#{cadastro_itens["item_#{form_item.id}(3i)"]}"
      texto.conteudo = data
      texto.save
   end

   def busca_avancada(form_item, params, valor=nil)
     data_inicio = ""
     data_inicio.concat(params[:cadastro]["item_inicio_#{form_item.id}(1i)"])
     data_inicio.concat("-")
     data_inicio.concat(params[:cadastro]["item_inicio_#{form_item.id}(2i)"])
     data_inicio.concat("-")
     data_inicio.concat(params[:cadastro]["item_inicio_#{form_item.id}(3i)"])

     data_fim = ""
     data_fim.concat(params[:cadastro]["item_fim_#{form_item.id}(1i)"])
     data_fim.concat("-")
     data_fim.concat(params[:cadastro]["item_fim_#{form_item.id}(2i)"])
     data_fim.concat("-")
     data_fim.concat(params[:cadastro]["item_fim_#{form_item.id}(3i)"])

     unless valor
      cads = EcmItemData.find(:all, :conditions=>["itensformulario_id = ? and
                                                    conteudo between ? and ?",
                                                    form_item.id,
                                                    data_inicio, data_fim]).collect {|c| c.cadastro_id}
     else
       cads = EcmItemTexto.find(:all, :conditions=>["itensformulario_id = ? and
                                                    conteudo like ?",
                                                    form_item.id,
                                                    "%#{valor}%"]).collect {|c| c.cadastro_id}
     end
   end

   def busca_cadastro_item(form_item, cadastro)
    EcmItemData.find(:first, :conditions=>["entidade_id = ? and
                                                   formulariocategoria_id = ? and
                                                   formulario_id = ? and
                                                   itensformulario_id = ? and
                                                   cadastro_id = ?",
                                                   cadastro.entidade_id,
                                                   cadastro.formulariocategoria_id,
                                                   cadastro.formulario_id,
                                                   form_item.id,
                                                   cadastro.id])
  end

  def deleta_cadastro_item(form_item, cadastro)
    EcmItemData.find(:first, :conditions=>["entidade_id = ? and
                                                   formulariocategoria_id = ? and
                                                   formulario_id = ? and
                                                   itensformulario_id = ? and
                                                   cadastro_id = ?",
                                                   cadastro.entidade_id,
                                                   cadastro.formulariocategoria_id,
                                                   cadastro.formulario_id,
                                                   form_item.id,
                                                   cadastro.id]).destroy
  end
end

