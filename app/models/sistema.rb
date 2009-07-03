class Sistema < CouchFoo::Base
  belongs_to :modulo
  has_many :gruposistemas

  property :modulo_id, String
  property :nome, String
  property :descricao, String
  property :rota, String
  property :controle, String
  property :menu, Boolean
  property :status, Boolean

  validates_presence_of :modulo_id
  validates_presence_of :nome
  validates_presence_of :descricao
  validates_presence_of :rota
  validates_presence_of :controle

  validates_uniqueness_of :nome
  validates_uniqueness_of :controle
end

