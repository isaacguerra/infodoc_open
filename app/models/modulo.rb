class Modulo < ActiveRecord::Base
  has_many :sistemas

  property :nome, String
  property :descricao, String

  validates_presence_of :nome
  validates_uniqueness_of :nome
  validates_presence_of :descricao
end

