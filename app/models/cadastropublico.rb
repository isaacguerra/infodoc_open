class Cadastropublico < ActiveRecord::Base
  belongs_to :entidade
  belongs_to :formulario

  validates_presence_of :entidade_id
  validates_presence_of :formulario_id
  validates_presence_of :titulo
  validates_presence_of :permissao

  serialize :filtro

  #scopos----------
  named_scope :ativo, :conditions=>["status = ? and principal_id is not null", true]
  named_scope :da_entidade, lambda {|id| {:conditions=>["entidade_id = ?", id]}}
  #-------------
end

