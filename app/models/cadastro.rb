class Cadastro < ActiveRecord::Base
  belongs_to :formulario
  has_many :ecm_item_textos
  has_many :ecm_item_texto_longos

  validates_presence_of :formulario_id
  validates_presence_of :entidade_id
  validates_presence_of :usuario_id
  validates_presence_of :formulariotipo_id
  validates_presence_of :formulariocategoria_id

  #scopos----------
  named_scope :ativo, :conditions=>{:status=>true}
  named_scope :da_entidade, lambda {|id| {:conditions=>["entidade_id = ?", id]}}
  named_scope :do_formulario, lambda {|id| {:conditions=>["formulario_id = ?", id]}}
  named_scope :do_tipo, lambda {|id| {:conditions=>["formulariotipo_id = ?", id]}}
  #-------------

  def monta_acessores(formulario)
    formulario.itensformularios.each do |form_item|
      cm = eval("#{form_item.itenstipo.componente.camelize}EcmBase.new")
      cm.acessores(self, form_item)
    end
  end

  def validar(formulario, cadastro_itens)
    formulario.itensformularios.each do |form_item|
      cm = eval("#{form_item.itenstipo.componente.camelize}EcmBase.new")
      cm.validar(self, form_item, cadastro_itens)
    end
  end

  def salvar_itens(cadastro_itens)
    self.formulario.itensformularios.each do |form_item|
      cm = eval("#{form_item.itenstipo.componente.camelize}EcmBase.new")
      cm.save(self, form_item, cadastro_itens)
    end
  end

  def update_itens(cadastro_itens)
    self.formulario.itensformularios.each do |form_item|
      cm = eval("#{form_item.itenstipo.componente.camelize}EcmBase.new")
      cm.update(self, form_item, cadastro_itens)
    end
  end

  def busca_form_item(item)
    if item.tipo.downcase == "texto"
      i = EcmItemTexto.find(:first, :conditions=>["entidade_id = ? and
                                                   formulariocategoria_id = ? and
                                                   formulario_id = ? and
                                                   itensformulario_id = ? and
                                                   cadastro_id = ?",
                                                   self.entidade_id,
                                                   self.formulariocategoria_id,
                                                   self.formulario_id,
                                                   item.id,
                                                   self.id])
      return i
    elsif item.tipo.downcase == "texto_longo"
      i = EcmItemTextoLongo.find(:first, :conditions=>["entidade_id = ? and
                                                   formulariocategoria_id = ? and
                                                   formulario_id = ? and
                                                   itensformulario_id = ? and
                                                   cadastro_id = ?",
                                                   self.entidade_id,
                                                   self.formulariocategoria_id,
                                                   self.formulario_id,
                                                   item.id,
                                                   self.id])
      return i
    elsif item.tipo.downcase == "numero_inteiro"
      i = EcmItemNumeroInteiro.find(:first, :conditions=>["entidade_id = ? and
                                                   formulariocategoria_id = ? and
                                                   formulario_id = ? and
                                                   itensformulario_id = ? and
                                                   cadastro_id = ?",
                                                   self.entidade_id,
                                                   self.formulariocategoria_id,
                                                   self.formulario_id,
                                                   item.id,
                                                   self.id])
      return i
    elsif item.tipo.downcase == "numero_decimal"
      i = EcmItemNumeroDecimal.find(:first, :conditions=>["entidade_id = ? and
                                                   formulariocategoria_id = ? and
                                                   formulario_id = ? and
                                                   itensformulario_id = ? and
                                                   cadastro_id = ?",
                                                   self.entidade_id,
                                                   self.formulariocategoria_id,
                                                   self.formulario_id,
                                                   item.id,
                                                   self.id])
      return i
    elsif item.tipo.downcase == "data"
      i = EcmItemData.find(:first, :conditions=>["entidade_id = ? and
                                                   formulariocategoria_id = ? and
                                                   formulario_id = ? and
                                                   itensformulario_id = ? and
                                                   cadastro_id = ?",
                                                   self.entidade_id,
                                                   self.formulariocategoria_id,
                                                   self.formulario_id,
                                                   item.id,
                                                   self.id])
      return i
    elsif item.tipo.downcase == "data_hora"
      i = EcmItemDataHora.find(:first, :conditions=>["entidade_id = ? and
                                                   formulariocategoria_id = ? and
                                                   formulario_id = ? and
                                                   itensformulario_id = ? and
                                                   cadastro_id = ?",
                                                   self.entidade_id,
                                                   self.formulariocategoria_id,
                                                   self.formulario_id,
                                                   item.id,
                                                   self.id])
      return i
    elsif item.tipo.downcase == "imagem"
      i = EcmItemImagem.find(:first, :conditions=>["entidade_id = ? and
                                                   formulariocategoria_id = ? and
                                                   formulario_id = ? and
                                                   itensformulario_id = ? and
                                                   cadastro_id = ?",
                                                   self.entidade_id,
                                                   self.formulariocategoria_id,
                                                   self.formulario_id,
                                                   item.id,
                                                   self.id])
      return i
    elsif item.tipo.downcase == "referncia"
      i = EcmItemReferencia.find(:first, :conditions=>["entidade_id = ? and
                                                   formulariocategoria_id = ? and
                                                   formulario_id = ? and
                                                   itensformulario_id = ? and
                                                   cadastro_id = ?",
                                                   self.entidade_id,
                                                   self.formulariocategoria_id,
                                                   self.formulario_id,
                                                   item.id,
                                                   self.id])
      return i
    end
  end
end

