class Itensformulario < ActiveRecord::Base
  belongs_to :itenstipo
  belongs_to :formulario

  serialize :opcoes

  validates_presence_of :entidade_id
  validates_presence_of :formulario_id
  validates_presence_of :itenstipo_id
  validates_presence_of :rotulo
  #validates_presence_of :posicao
  validates_presence_of :tipo
  validates_presence_of :componente
  validates_presence_of :opcoes

  #scopos----------
  named_scope :da_entidade, lambda {|id| {:conditions=>["entidade_id = ?", id]}}
  named_scope :do_formulario, lambda {|id| {:conditions=>["formulario_id = ?", id]}}
  named_scope :do_itenstipo, lambda {|id| {:conditions=>["itenstipo_id = ?", id]}}
  named_scope :do_tipo, lambda {|id| {:conditions=>["tipo = ?", id]}}
  #-------------

  after_create :apos_criar_item

  def validar_opcoes
    vo = eval("#{self.componente.camelize}EcmBase.new")
    return vo.validar_opcoes(self)
  end

  def apos_criar_item
    it = eval("#{self.componente.camelize}EcmBase.new")
    return it.apos_criar_item(self)
  end

  def antes_de_remover
    if self.formulario.cadastros.size > 0
    end
  end

  def salvar_item(itenstipo, params)
      cm = eval("#{itenstipo.componente.camelize}EcmBase.new")
      return cm.salvar_item(self, params)
  end

  def update_item(cadastro_itens)
    self.formulario.itensformularios.each do |form_item|
      cm = eval("#{form_item.itenstipo.componente.camelize}EcmBase.new")
      cm.update(self, form_item, cadastro_itens)
    end
  end
end

