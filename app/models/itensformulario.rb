class Itensformulario < ActiveRecord::Base
  belongs_to :itenstipo
  belongs_to :formulario

  serialize :opcoes

  validates_presence_of :entidade_id
  validates_presence_of :formulario_id
  #validates_presence_of :itenstipo_id
  #validates_presence_of :rotulo
  #validates_presence_of :posicao
  #validates_presence_of :tipo
  #validates_presence_of :componente
  #validates_presence_of :opcoes

  #scopos----------
  named_scope :da_entidade, lambda {|id| {:conditions=>["entidade_id = ?", id]}}
  named_scope :do_formulario, lambda {|id| {:conditions=>["formulario_id = ?", id]}}
  named_scope :do_itenstipo, lambda {|id| {:conditions=>["itenstipo_id = ?", id]}}
  named_scope :do_tipo, lambda {|id| {:conditions=>["tipo = ?", id]}}
  #-------------

end

