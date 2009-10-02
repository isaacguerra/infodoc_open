class Blog < ActiveRecord::Base
  belongs_to :usuario
  validates_presence_of :entidade_id
  validates_presence_of :usuario_id
  validates_presence_of :menssagem

  validates_length_of :menssagem, :maximum=>255

  named_scope :da_entidade, lambda {|id| {:conditions=>["entidade_id = ?", id]}}
end

