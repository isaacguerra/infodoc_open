class Cadastro < ActiveRecord::Base
  belongs_to :formulario
  has_many :ecm_item_textos
  has_many :ecm_item_texto_longos
  has_many :comentarios, :as=>:comentavel
  has_one :artefato

  acts_as_tree

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

  before_destroy :antes_de_deletar

  def acessores(nome)
    code = "@#{nome}; "
    code << "def #{nome}=(valor); @#{nome}=valor; end;"
    code << "def #{nome}(); return @item_#{nome}; end;"
    self.instance_eval(code)
  end

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

  def deletavel
    ref = EcmItemReferencia.count(:id, :conditions=>["referencia_id = ?", self.id])
    if ref == 0
      return true
    else
      return false
    end
  end

  def antes_de_deletar
    self.formulario.itensformularios.each do |form_item|
      cm = eval("#{form_item.itenstipo.componente.camelize}EcmBase.new")
      cm.deleta_cadastro_item(form_item, self)
    end
  end
end

