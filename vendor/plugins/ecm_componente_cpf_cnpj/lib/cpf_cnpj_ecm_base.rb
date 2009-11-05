class CpfCnpjEcmBase
#-----------------------------------------------------------------------------------------------------------------------------------------------------
# ITEM DO FORMULARIO
  def salvar_item(item_form, params)
    item_form.opcoes = params[:opcoes]
    return item_form.save
  end

  def apos_criar_item(form_item)
    if form_item.formulario.cadastros.size > 0
      form_item.formulario.cadastros.each do |cadastro|
        texto = EcmItemTexto.new
        texto.entidade_id = cadastro.entidade_id
        texto.formulariocategoria_id = cadastro.formulario.formulariocategoria_id
        texto.formulario_id = cadastro.formulario_id
        texto.itensformulario_id = form_item.id
        texto.cadastro_id = cadastro.id
        texto.conteudo = ""
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
      if form_item.opcoes[:nulo] == "0" and cadastro_itens["item_#{form_item.id}"] == ""
        cadastro.errors.add("item_#{form_item.id}", "Campo #{form_item.rotulo} Requerido!")
      end
      if form_item.opcoes[:unico] == "1"
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

      if form_item.opcoes[:tipo] == "1"
        cadastro.errors.add("item_#{form_item.id}", "O #{form_item.rotulo} não é válido!") unless valida_cpf(cadastro_itens["item_#{form_item.id}"])
      elsif form_item.opcoes[:tipo] == "2"
        cadastro.errors.add("item_#{form_item.id}", "O #{form_item.rotulo} não é válido!") unless valida_cnpj(cadastro_itens["item_#{form_item.id}"])
      else
        if cadastro_itens["item_#{form_item.id}"]
          if cadastro_itens["item_#{form_item.id}"].size == 18
            cadastro.errors.add("item_#{form_item.id}", "O #{form_item.rotulo} não é válido!") unless valida_cnpj(cadastro_itens["item_#{form_item.id}"])
          elsif cadastro_itens["item_#{form_item.id}"].size == 14
            cadastro.errors.add("item_#{form_item.id}", "O #{form_item.rotulo} não é válido!") unless valida_cpf(cadastro_itens["item_#{form_item.id}"])
          else
            cadastro.errors.add("item_#{form_item.id}", "O #{form_item.rotulo} não é válido!")
          end
        else
          cadastro.errors.add("item_#{form_item.id}", "O #{form_item.rotulo} não é válido!")
        end
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

   def busca_avancada(form_item, params, valor=nil)
     unless valor
      cads = EcmItemTexto.find(:all, :conditions=>["itensformulario_id = ? and
                                                    conteudo like ?",
                                                    form_item.id,
                                                    "%#{params[:cadastro]["item_#{form_item.id}"]}%"]).collect {|c| c.cadastro_id}
     else
       cads = EcmItemTexto.find(:all, :conditions=>["itensformulario_id = ? and
                                                    conteudo like ?",
                                                    form_item.id,
                                                    "%#{valor}%"]).collect {|c| c.cadastro_id}
     end
   end

   def valida_cnpj(cnpj = nil)
	    return nil if cnpj.nil?

	    nulos = %w{11111111111111
	               22222222222222
	               33333333333333
	               44444444444444
	               55555555555555
	               66666666666666
	               77777777777777
	               88888888888888
	               99999999999999
	               00000000000000}

	    valor = cnpj.scan(/[0-9]/).collect{|x| x.to_i}

	    fatores = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]

	    if valor.length == 14 and not nulos.member?(valor.to_s)
	      soma = 0
	      0.upto(11) do |i|
	        soma += valor[i] * fatores[i]
	      end

	      resto = soma % 11
	      dv1 = resto < 2 ? 0 : 11 - resto

       if dv1 == valor[12]
	        soma = 0
	        0.upto(12) do |i|
	          soma += valor[i] * (i == 0 ? 6 : fatores[i-1])
	        end

	        resto = soma % 11
	        dv2 = resto < 2 ? 0 : 11 - resto

	        return true if dv2 == valor[13]
	      end
	    end
	    return nil
	  end

    def valida_cpf(cpf = nil)
      return nil if cpf.nil?

      nulos = %w{12345678909
                 11111111111
                 22222222222
                 33333333333
                 44444444444
                 55555555555
                 66666666666
                 77777777777
                 88888888888
                 99999999999
                 00000000000}

      valor = cpf.scan /[0-9]/

      if valor.length == 11
        unless nulos.member?(valor.join)
          valor = valor.collect{|x| x.to_i}

          # Calcula o primeiro digito verificador
          soma = 0
          0.upto(8) do |i|
            soma += valor[i] * (10 - i)
          end

          soma = soma - (11 * (soma/11))
          dv1 = soma < 2 ? 0 : 11 - soma

          if dv1 == valor[9]
            # Calcula o segundo digito verificador
            soma = 0
            0.upto(8) do |i|
              soma += valor[i] * (11 - i)
            end

            soma += dv1 * 2
            valorr = (soma / 11) * 11
            resultado = soma - valorr
            dv2 = resultado < 2 ? 0 : 11 - resultado

            return true if dv2 == valor[10]
          end
        end
      end
      return nil
    end

    def busca_cadastro_item(form_item, cadastro)
    EcmItemTexto.find(:first, :conditions=>["entidade_id = ? and
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
    EcmItemTexto.find(:first, :conditions=>["entidade_id = ? and
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

