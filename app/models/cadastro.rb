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
    formulario.itensformularios.each do |i|
      cm = eval("Ecm#{i.itenstipo.componente.capitalize}Base.new")
      cm.acessores(self, i)
    end
  end

  def validar(formulario, itens_form)
    formulario.itensformularios.each do |item|
      cm = eval("Ecm#{item.itenstipo.componente.capitalize}Base.new")
      cm.validar(self, item, itens_form)
    end
  end

  def salvar_itens(itens_form)
    self.formulario.itensformularios.each do |item|
      cm = eval("Ecm#{item.itenstipo.componente.capitalize}Base.new")
      cm.save(self, item, itens_form)
    end
  end

  def update_itens(itens_form)
    self.formulario.itensformularios.each do |item|
      cm = eval("Ecm#{item.itenstipo.componente.capitalize}Base.new")
      cm.update(self, item, itens_form)
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
    end
  end
end

