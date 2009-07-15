class Grupoformulario < ActiveRecord::Base
  belongs_to :grupo
  belongs_to :formulario

  validates_presence_of :grupo_id
  validates_presence_of :formulario_id
  validates_presence_of :permissao
  #scopos----------
  named_scope :do_formulario, lambda {|id| {:conditions=>["formulario_id = ?", id]}}
  #-------------
end

