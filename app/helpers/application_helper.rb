# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def f_data(d)
      "#{d.to_s[8..9]}/#{d.to_s[5..6]}/#{d.to_s[0..3]}"
  end

  def status(valor)
    if valor
      return "Ativo"
    else
      return "Inativo"
    end
  end

  def ecm_item(tipo, acao, opcoes = nil)
    if opcoes
      eval("#{tipo}_#{acao}_item(opcoes)")
    else
      eval("#{tipo}_#{acao}_item")
    end
  end

  def ecm_new_form(tipo, item)
    eval("#{tipo}_new_form(item)")
  end

  def ecm_edit_form(tipo, item, item_form)
    eval("#{tipo}_edit_form(item, item_form)")
  end

  def ecm_show_form(tipo, item, itemform)
    eval("#{tipo}_show_form(item, itemform)")
  end
end

