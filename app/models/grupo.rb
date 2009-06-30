class Grupo < CouchFoo::Base
  belongs_to :entidade
  has_many :gruposistemas
  has_many :grupousuarios
  has_many :usuarios, :through => :grupousuarios
  has_many :sistemas, :through => :gruposistemas

  property :entidade_id, String
  property :nome, String
  property :descricao, String

  validates_presence_of :entidade_id
  validates_presence_of :nome
  validates_presence_of :descricao

end

