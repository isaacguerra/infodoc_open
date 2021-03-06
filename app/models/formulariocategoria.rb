class Formulariocategoria < ActiveRecord::Base
  has_many :formularios, :dependent => :destroy
  belongs_to :entidade

  validates_presence_of :entidade_id
  validates_presence_of :nome

  #scopos----------
  named_scope :da_entidade, lambda {|id| {:conditions=>["entidade_id = ?", id]}}
  #-------------

end

