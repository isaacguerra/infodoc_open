class Grupo < ActiveRecord::Base
  belongs_to :entidade
  has_many :gruposistemas
  has_many :grupousuarios
  has_many :usuarios, :through => :grupousuarios
  has_many :sistemas, :through => :gruposistemas

  validates_presence_of :entidade_id
  validates_presence_of :nome
  validates_presence_of :descricao

  #scopos----------
  named_scope :da_entidade, lambda {|id| {:conditions=>["entidade_id = ?", id]}}
  #-------------

end

