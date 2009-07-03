class Modulo < CouchFoo::Base
  has_many :sistemas
  has_many :moduloentidades

  property :nome, String
  property :descricao, String

  validates_presence_of :nome
  validates_uniqueness_of :nome
  validates_presence_of :descricao
end

