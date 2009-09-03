class DataHoraEcmBase
#-----------------------------------------------------------------------------------------------------------------------------------------------------
# ITEM DO FORMULARIO
  def salvar_item(item_form, params)
    item_form.opcoes = params[:opcoes]
    return item_form.save
  end

  def apos_criar_item(form_item)
    if form_item.formulario.cadastros.size > 0
      form_item.formulario.cadastros.each do |cadastro|
        texto = EcmItemDataHora.new
        texto.entidade_id = cadastro.entidade_id
        texto.formulariocategoria_id = cadastro.formulario.formulariocategoria_id
        texto.formulario_id = cadastro.formulario_id
        texto.itensformulario_id = form_item.id
        texto.cadastro_id = cadastro.id
        texto.conteudo = DateTime.now
        texto.save
      end
    end
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
     return true
   end

   def save(cadastro, form_item, cadastro_itens)
      texto = EcmItemDataHora.new
      texto.entidade_id = cadastro.entidade_id
      texto.formulariocategoria_id = cadastro.formulario.formulariocategoria_id
      texto.formulario_id = cadastro.formulario_id
      texto.itensformulario_id = form_item.id
      texto.cadastro_id = cadastro.id

      data = ""
      if form_item.opcoes[:readonly] == "0"
        data.concat(cadastro_itens["item_#{form_item.id}(1i)"])
        data.concat("-")
        data.concat(cadastro_itens["item_#{form_item.id}(2i)"])
        data.concat("-")
        data.concat(cadastro_itens["item_#{form_item.id}(3i)"])
        data.concat(" ")
        data.concat(cadastro_itens["item_#{form_item.id}(4i)"])
        data.concat(":")
        data.concat(cadastro_itens["item_#{form_item.id}(5i)"])
      else
        data.concat(cadastro_itens["item_#{form_item.id}"][6..9])
        data.concat("-")
        data.concat(cadastro_itens["item_#{form_item.id}"][3..4])
        data.concat("-")
        data.concat(cadastro_itens["item_#{form_item.id}"][0..1])
        data.concat(" ")
        data.concat(cadastro_itens["item_#{form_item.id}"][11..12])
        data.concat(":")
        data.concat(cadastro_itens["item_#{form_item.id}"][14..15])
      end
      texto.conteudo = data
      texto.save
   end

   def update(cadastro, form_item, cadastro_itens)
     texto = EcmItemDataHora.find(:first, :conditions=>["entidade_id = ? and
                                                   formulariocategoria_id = ? and
                                                   formulario_id = ? and
                                                   itensformulario_id = ? and
                                                   cadastro_id = ?",
                                                   cadastro.entidade_id,
                                                   cadastro.formulariocategoria_id,
                                                   cadastro.formulario_id,
                                                   form_item.id,
                                                   cadastro.id])
      data = ""
      if form_item.opcoes[:readonly] == "0"
        data.concat(cadastro_itens["item_#{form_item.id}(1i)"])
        data.concat("-")
        data.concat(cadastro_itens["item_#{form_item.id}(2i)"])
        data.concat("-")
        data.concat(cadastro_itens["item_#{form_item.id}(3i)"])
        data.concat(" ")
        data.concat(cadastro_itens["item_#{form_item.id}(4i)"])
        data.concat(":")
        data.concat(cadastro_itens["item_#{form_item.id}(5i)"])
      else
        data.concat(cadastro_itens["item_#{form_item.id}"][6..9])
        data.concat("-")
        data.concat(cadastro_itens["item_#{form_item.id}"][3..4])
        data.concat("-")
        data.concat(cadastro_itens["item_#{form_item.id}"][0..1])
        data.concat(" ")
        data.concat(cadastro_itens["item_#{form_item.id}"][11..12])
        data.concat(":")
        data.concat(cadastro_itens["item_#{form_item.id}"][14..15])
      end
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
     data_inicio.concat(" ")
     data_inicio.concat(params[:cadastro]["item_inicio_#{form_item.id}(4i)"])
     data_inicio.concat(":")
     data_inicio.concat(params[:cadastro]["item_inicio_#{form_item.id}(5i)"])

     data_fim = ""
     data_fim.concat(params[:cadastro]["item_fim_#{form_item.id}(1i)"])
     data_fim.concat("-")
     data_fim.concat(params[:cadastro]["item_fim_#{form_item.id}(2i)"])
     data_fim.concat("-")
     data_fim.concat(params[:cadastro]["item_fim_#{form_item.id}(3i)"])
     data_fim.concat(" ")
     data_fim.concat(params[:cadastro]["item_fim_#{form_item.id}(4i)"])
     data_fim.concat(":")
     data_fim.concat(params[:cadastro]["item_fim_#{form_item.id}(5i)"])

     unless valor
      cads = EcmItemDataHora.find(:all, :conditions=>["itensformulario_id = ? and
                                                    conteudo between ? and ?",
                                                    form_item.id,
                                                    data_inicio, data_fim]).collect {|c| c.cadastro_id}
     else
#       cads = EcmItemTexto.find(:all, :conditions=>["itensformulario_id = ? and
#                                                    conteudo like ?",
#                                                    form_item.id,
#                                                    "%#{valor}%"]).collect {|c| c.cadastro_id}
     end
   end
end

