class Cadastro < ActiveRecord::Base
  belongs_to :formulario

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

end

