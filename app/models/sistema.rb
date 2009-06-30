class Sistema < CouchFoo::Base
  belongs_to :modulo
  has_many :gruposistemas
  has_many :grupos, :through => :gruposistemas

  property :modulo_id, String
  property :nome, String
  property :descricao, String
  property :rota, String
  property :classe, String
  property :status, Bollean

  validates_presence_of :modulo_id
  validates_presence_of :nome
  validates_presence_of :descricao
  validates_presence_of :rota
  validates_presence_of :classe
  validates_presence_of :status

  validates_uniqueness_of :nome
  validates_uniqueness_of :rota
  validates_uniqueness_of :classe
end

