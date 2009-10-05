class UsuarioBlog < ActiveRecord::Base
  belongs_to :usuario
  validates_presence_of :entidade_id
  validates_presence_of :usuario_id
  validates_presence_of :seguido_id

  named_scope :da_entidade, lambda {|id| {:conditions=>["entidade_id = ?", id]}}
  named_scope :seguidores_de, lambda {|id| {:conditions=>["seguido_id = ?", id]}}
end

